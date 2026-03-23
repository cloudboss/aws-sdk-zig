const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const DistributionMetricName = @import("distribution_metric_name.zig").DistributionMetricName;
const MetricStatistic = @import("metric_statistic.zig").MetricStatistic;
const MetricUnit = @import("metric_unit.zig").MetricUnit;
const MetricDatapoint = @import("metric_datapoint.zig").MetricDatapoint;

pub const GetDistributionMetricDataInput = struct {
    /// The name of the distribution for which to get metric data.
    ///
    /// Use the `GetDistributions` action to get a list of distribution names that
    /// you
    /// can specify.
    distribution_name: []const u8,

    /// The end of the time interval for which to get metric data.
    ///
    /// Constraints:
    ///
    /// * Specified in Coordinated Universal Time (UTC).
    ///
    /// * Specified in the Unix time format.
    ///
    /// For example, if you wish to use an end time of October 1, 2018, at 9 PM UTC,
    /// specify
    /// `1538427600` as the end time.
    ///
    /// You can convert a human-friendly time to Unix time format using a converter
    /// like [Epoch converter](https://www.epochconverter.com/).
    end_time: i64,

    /// The metric for which you want to return information.
    ///
    /// Valid distribution metric names are listed below, along with the most useful
    /// `statistics` to include in your request, and the published `unit`
    /// value.
    ///
    /// * **
    /// `Requests`
    /// ** - The total number of viewer
    /// requests received by your Lightsail distribution, for all HTTP methods, and
    /// for both
    /// HTTP and HTTPS requests.
    ///
    /// `Statistics`: The most useful statistic is `Sum`.
    ///
    /// `Unit`: The published unit is `None`.
    ///
    /// * **
    /// `BytesDownloaded`
    /// ** - The number of bytes
    /// downloaded by viewers for GET, HEAD, and OPTIONS requests.
    ///
    /// `Statistics`: The most useful statistic is `Sum`.
    ///
    /// `Unit`: The published unit is `None`.
    ///
    /// * **
    /// `BytesUploaded `
    /// ** - The number of bytes
    /// uploaded to your origin by your Lightsail distribution, using POST and PUT
    /// requests.
    ///
    /// `Statistics`: The most useful statistic is `Sum`.
    ///
    /// `Unit`: The published unit is `None`.
    ///
    /// * **
    /// `TotalErrorRate`
    /// ** - The percentage of all
    /// viewer requests for which the response's HTTP status code was 4xx or 5xx.
    ///
    /// `Statistics`: The most useful statistic is `Average`.
    ///
    /// `Unit`: The published unit is `Percent`.
    ///
    /// * **
    /// `4xxErrorRate`
    /// ** - The percentage of all
    /// viewer requests for which the response's HTTP status cod was 4xx. In these
    /// cases, the
    /// client or client viewer may have made an error. For example, a status code
    /// of 404 (Not
    /// Found) means that the client requested an object that could not be found.
    ///
    /// `Statistics`: The most useful statistic is `Average`.
    ///
    /// `Unit`: The published unit is `Percent`.
    ///
    /// * **
    /// `5xxErrorRate`
    /// ** - The percentage of all
    /// viewer requests for which the response's HTTP status code was 5xx. In these
    /// cases, the
    /// origin server did not satisfy the requests. For example, a status code of
    /// 503 (Service
    /// Unavailable) means that the origin server is currently unavailable.
    ///
    /// `Statistics`: The most useful statistic is `Average`.
    ///
    /// `Unit`: The published unit is `Percent`.
    metric_name: DistributionMetricName,

    /// The granularity, in seconds, for the metric data points that will be
    /// returned.
    period: i32,

    /// The start of the time interval for which to get metric data.
    ///
    /// Constraints:
    ///
    /// * Specified in Coordinated Universal Time (UTC).
    ///
    /// * Specified in the Unix time format.
    ///
    /// For example, if you wish to use a start time of October 1, 2018, at 8 PM
    /// UTC, specify
    /// `1538424000` as the start time.
    ///
    /// You can convert a human-friendly time to Unix time format using a converter
    /// like [Epoch converter](https://www.epochconverter.com/).
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
    /// * `Average` - The value of Sum / SampleCount during the specified period. By
    /// comparing this statistic with the Minimum and Maximum values, you can
    /// determine the full
    /// scope of a metric and how close the average use is to the Minimum and
    /// Maximum values. This
    /// comparison helps you to know when to increase or decrease your resources.
    ///
    /// * `SampleCount` - The count, or number, of data points used for the
    /// statistical calculation.
    statistics: []const MetricStatistic,

    /// The unit for the metric data request.
    ///
    /// Valid units depend on the metric data being requested. For the valid units
    /// with each
    /// available metric, see the `metricName` parameter.
    unit: MetricUnit,

    pub const json_field_names = .{
        .distribution_name = "distributionName",
        .end_time = "endTime",
        .metric_name = "metricName",
        .period = "period",
        .start_time = "startTime",
        .statistics = "statistics",
        .unit = "unit",
    };
};

pub const GetDistributionMetricDataOutput = struct {
    /// An array of objects that describe the metric data returned.
    metric_data: ?[]const MetricDatapoint = null,

    /// The name of the metric returned.
    metric_name: ?DistributionMetricName = null,

    pub const json_field_names = .{
        .metric_data = "metricData",
        .metric_name = "metricName",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetDistributionMetricDataInput, options: CallOptions) !GetDistributionMetricDataOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "lightsail");

    var response = try client.http_client.sendRequest(&request);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = parseErrorResponse(client.allocator, response.body, response.status) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: GetDistributionMetricDataInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("lightsail", "Lightsail", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = "/";
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "Lightsail_20161128.GetDistributionMetricData");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetDistributionMetricDataOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(GetDistributionMetricDataOutput, body, allocator);
}

fn parseErrorResponse(allocator: std.mem.Allocator, body: []const u8, status: u16) !ServiceError {
    const error_code = blk: {
        const type_str = aws.json.findJsonValue(body, "__type") orelse break :blk @as([]const u8, "Unknown");
        if (std.mem.lastIndexOfScalar(u8, type_str, '#')) |idx| {
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
