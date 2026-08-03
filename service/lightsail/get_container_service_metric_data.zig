const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const errors = @import("errors.zig");
const ServiceError = errors.ServiceError;
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

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetContainerServiceMetricDataInput, options: CallOptions) !GetContainerServiceMetricDataOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "lightsail", client.config.http_client.clock_skew_offset);

    var response = try client.config.http_client.sendRequestWithOptions(&request, client.options);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = parseErrorResponse(client.allocator, response.body, response.status) catch return error.OutOfMemory;
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: GetContainerServiceMetricDataInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("lightsail", "Lightsail", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "Lightsail_20161128.GetContainerServiceMetricData");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetContainerServiceMetricDataOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(GetContainerServiceMetricDataOutput, body, allocator);
}

fn parseErrorResponse(allocator: std.mem.Allocator, body: []const u8, status: u16) !ServiceError {
    const error_code = blk: {
        const type_str = aws.json.findJsonValue(body, "__type") orelse break :blk @as([]const u8, "Unknown");
        if (std.mem.findScalarLast(u8, type_str, '#')) |idx| {
            break :blk type_str[idx + 1 ..];
        }
        break :blk type_str;
    };
    const error_message = aws.json.findJsonValue(body, "message") orelse aws.json.findJsonValue(body, "Message") orelse "";
    var arena = std.heap.ArenaAllocator.init(allocator);
    errdefer arena.deinit();
    const arena_alloc = arena.allocator();
    const owned_message = try arena_alloc.dupe(u8, error_message);
    const owned_request_id = try arena_alloc.dupe(u8, "");

    if (std.mem.eql(u8, error_code, "AccessDeniedException")) {
        const parsed_error: ?errors.AccessDeniedException = aws.json.parseJsonObject(errors.AccessDeniedException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .access_denied_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "AccountSetupInProgressException")) {
        const parsed_error: ?errors.AccountSetupInProgressException = aws.json.parseJsonObject(errors.AccountSetupInProgressException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .account_setup_in_progress_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidInputException")) {
        const parsed_error: ?errors.InvalidInputException = aws.json.parseJsonObject(errors.InvalidInputException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_input_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "NotFoundException")) {
        const parsed_error: ?errors.NotFoundException = aws.json.parseJsonObject(errors.NotFoundException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .not_found_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "OperationFailureException")) {
        const parsed_error: ?errors.OperationFailureException = aws.json.parseJsonObject(errors.OperationFailureException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .operation_failure_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "RegionSetupInProgressException")) {
        const parsed_error: ?errors.RegionSetupInProgressException = aws.json.parseJsonObject(errors.RegionSetupInProgressException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .region_setup_in_progress_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ServiceException")) {
        const parsed_error: ?errors.ServiceException = aws.json.parseJsonObject(errors.ServiceException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .service_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "UnauthenticatedException")) {
        const parsed_error: ?errors.UnauthenticatedException = aws.json.parseJsonObject(errors.UnauthenticatedException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .unauthenticated_exception = typed_error } };
        }
    }

    const owned_code = try arena_alloc.dupe(u8, error_code);
    return .{ .arena = arena, .kind = .{ .unknown = .{
        .code = owned_code,
        .message = owned_message,
        .request_id = owned_request_id,
        .http_status = status,
    } } };
}
