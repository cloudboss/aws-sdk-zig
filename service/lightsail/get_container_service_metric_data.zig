const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const ContainerServiceMetricName = @import("container_service_metric_name.zig").ContainerServiceMetricName;
const MetricStatistic = @import("metric_statistic.zig").MetricStatistic;
const MetricDatapoint = @import("metric_datapoint.zig").MetricDatapoint;

pub const GetContainerServiceMetricDataInput = struct {
    /// The end time of the time period.
    end_time: i64,

    /// The metric for which you want to return information.
    ///
    /// Valid container service metric names are listed below, along with the most
    /// useful
    /// statistics to include in your request, and the published unit value.
    ///
    /// * `CPUUtilization` - The average percentage of compute units that are
    /// currently in use across all nodes of the container service. This metric
    /// identifies the
    /// processing power required to run containers on each node of the container
    /// service.
    ///
    /// Statistics: The most useful statistics are `Maximum` and
    /// `Average`.
    ///
    /// Unit: The published unit is `Percent`.
    ///
    /// * `MemoryUtilization` - The average percentage of available memory that is
    /// currently in use across all nodes of the container service. This metric
    /// identifies the
    /// memory required to run containers on each node of the container service.
    ///
    /// Statistics: The most useful statistics are `Maximum` and
    /// `Average`.
    ///
    /// Unit: The published unit is `Percent`.
    metric_name: ContainerServiceMetricName,

    /// The granularity, in seconds, of the returned data points.
    ///
    /// All container service metric data is available in 5-minute (300 seconds)
    /// granularity.
    period: i32,

    /// The name of the container service for which to get metric data.
    service_name: []const u8,

    /// The start time of the time period.
    start_time: i64,

    /// The statistic for the metric.
    ///
    /// The following statistics are available:
    ///
    /// * `Minimum` - The lowest value observed during the specified period. Use
    ///   this
    /// value to determine low volumes of activity for your application.
    ///
    /// * `Maximum` - The highest value observed during the specified period. Use
    /// this value to determine high volumes of activity for your application.
    ///
    /// * `Sum` - All values submitted for the matching metric added together. You
    /// can use this statistic to determine the total volume of a metric.
    ///
    /// * `Average` - The value of `Sum` / `SampleCount` during
    /// the specified period. By comparing this statistic with the `Minimum` and
    /// `Maximum` values, you can determine the full scope of a metric and how close
    /// the average use is to the `Minimum` and `Maximum` values. This
    /// comparison helps you to know when to increase or decrease your resources.
    ///
    /// * `SampleCount` - The count, or number, of data points used for the
    /// statistical calculation.
    statistics: []const MetricStatistic,

    pub const json_field_names = .{
        .end_time = "endTime",
        .metric_name = "metricName",
        .period = "period",
        .service_name = "serviceName",
        .start_time = "startTime",
        .statistics = "statistics",
    };
};

pub const GetContainerServiceMetricDataOutput = struct {
    /// An array of objects that describe the metric data returned.
    metric_data: ?[]const MetricDatapoint = null,

    /// The name of the metric returned.
    metric_name: ?ContainerServiceMetricName = null,

    pub const json_field_names = .{
        .metric_data = "metricData",
        .metric_name = "metricName",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetContainerServiceMetricDataInput, options: Options) !GetContainerServiceMetricDataOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "lightsail");

    var response = try client.http_client.sendRequest(&request);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = parseErrorResponse(response.body, response.status, client.allocator) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(response.body, response.status, response.headers, allocator);
    return result;
}

fn serializeRequest(alloc: std.mem.Allocator, input: GetContainerServiceMetricDataInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("lightsail", "Lightsail", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const body = try aws.json.jsonStringify(input, alloc);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = "/";
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(alloc, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(alloc, "X-Amz-Target", "Lightsail_20161128.GetContainerServiceMetricData");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !GetContainerServiceMetricDataOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(GetContainerServiceMetricDataOutput, body, alloc);
}

fn parseErrorResponse(body: []const u8, status: u16, alloc: std.mem.Allocator) !ServiceError {
    const error_code = blk: {
        const type_str = aws.json.findJsonValue(body, "__type") orelse break :blk @as([]const u8, "Unknown");
        if (std.mem.lastIndexOfScalar(u8, type_str, '#')) |idx| {
            break :blk type_str[idx + 1 ..];
        }
        break :blk type_str;
    };
    const error_message = aws.json.findJsonValue(body, "message") orelse aws.json.findJsonValue(body, "Message") orelse "";
    var arena = std.heap.ArenaAllocator.init(alloc);
    errdefer arena.deinit();
    const arena_alloc = arena.allocator();
    const owned_message = try arena_alloc.dupe(u8, error_message);
    const owned_request_id = try arena_alloc.dupe(u8, "");

    if (std.mem.eql(u8, error_code, "AccessDeniedException")) {
        return .{ .arena = arena, .kind = .{ .access_denied_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "AccountSetupInProgressException")) {
        return .{ .arena = arena, .kind = .{ .account_setup_in_progress_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidInputException")) {
        return .{ .arena = arena, .kind = .{ .invalid_input_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "NotFoundException")) {
        return .{ .arena = arena, .kind = .{ .not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "OperationFailureException")) {
        return .{ .arena = arena, .kind = .{ .operation_failure_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "RegionSetupInProgressException")) {
        return .{ .arena = arena, .kind = .{ .region_setup_in_progress_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ServiceException")) {
        return .{ .arena = arena, .kind = .{ .service_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "UnauthenticatedException")) {
        return .{ .arena = arena, .kind = .{ .unauthenticated_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }

    const owned_code = try arena_alloc.dupe(u8, error_code);
    return .{ .arena = arena, .kind = .{ .unknown = .{
        .code = owned_code,
        .message = owned_message,
        .request_id = owned_request_id,
        .http_status = status,
    } } };
}
