const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const MetricQuery = @import("metric_query.zig").MetricQuery;
const PeriodAlignment = @import("period_alignment.zig").PeriodAlignment;
const ServiceType = @import("service_type.zig").ServiceType;
const MetricKeyDataPoints = @import("metric_key_data_points.zig").MetricKeyDataPoints;

pub const GetResourceMetricsInput = struct {
    /// The date and time specifying the end of the requested time series query
    /// range. The value
    /// specified is *exclusive*. Thus, the command returns data points less than
    /// (but not equal to) `EndTime`.
    ///
    /// The value for `EndTime` must be later than the value for `StartTime`.
    end_time: i64,

    /// An immutable identifier for a data source that is unique for an Amazon Web
    /// Services Region. Performance Insights gathers metrics from this data source.
    /// In the
    /// console, the identifier is shown as *ResourceID*. When you call
    /// `DescribeDBInstances`, the identifier is
    /// returned as `DbiResourceId`.
    ///
    /// To use a DB instance as a data source, specify its `DbiResourceId` value.
    /// For example, specify
    /// `db-ABCDEFGHIJKLMNOPQRSTU1VW2X`.
    identifier: []const u8,

    /// The maximum number of items to return in the response.
    max_results: ?i32 = null,

    /// An array of one or more queries to perform. Each query must specify a
    /// Performance Insights metric and specify an aggregate function, and you can
    /// provide filtering
    /// criteria. You must append the aggregate function to the metric. For example,
    /// to find the average for the metric `db.load`
    /// you must use `db.load.avg`. Valid values for aggregate functions include
    /// `.avg`, `.min`,
    /// `.max`, and `.sum`.
    metric_queries: []const MetricQuery,

    /// An optional pagination token provided by a previous request. If this
    /// parameter is specified, the response includes only records beyond
    /// the token, up to the value specified by `MaxRecords`.
    next_token: ?[]const u8 = null,

    /// The returned timestamp which is the start or end time of the time periods.
    /// The default value is `END_TIME`.
    period_alignment: ?PeriodAlignment = null,

    /// The granularity, in seconds, of the data points returned from Performance
    /// Insights. A period can be as short as one second, or as long as one day
    /// (86400
    /// seconds). Valid values are:
    ///
    /// * `1` (one second)
    ///
    /// * `60` (one minute)
    ///
    /// * `300` (five minutes)
    ///
    /// * `3600` (one hour)
    ///
    /// * `86400` (twenty-four hours)
    ///
    /// If you don't specify `PeriodInSeconds`, then Performance Insights will
    /// choose a value for you, with a goal of returning roughly 100-200 data
    /// points in the response.
    period_in_seconds: ?i32 = null,

    /// The Amazon Web Services service for which Performance Insights returns
    /// metrics. Valid values are as follows:
    ///
    /// * `RDS`
    ///
    /// * `DOCDB`
    service_type: ServiceType,

    /// The date and time specifying the beginning of the requested time series
    /// query range. You can't
    /// specify a `StartTime` that is earlier than 7 days ago. By default,
    /// Performance Insights has 7 days of
    /// retention, but you can extend this range up to 2 years. The value specified
    /// is
    /// *inclusive*. Thus, the command returns data points equal to or greater
    /// than `StartTime`.
    ///
    /// The value for `StartTime` must be earlier than the value for `EndTime`.
    start_time: i64,

    pub const json_field_names = .{
        .end_time = "EndTime",
        .identifier = "Identifier",
        .max_results = "MaxResults",
        .metric_queries = "MetricQueries",
        .next_token = "NextToken",
        .period_alignment = "PeriodAlignment",
        .period_in_seconds = "PeriodInSeconds",
        .service_type = "ServiceType",
        .start_time = "StartTime",
    };
};

pub const GetResourceMetricsOutput = struct {
    /// The end time for the returned metrics, after alignment to a granular
    /// boundary (as specified by `PeriodInSeconds`).
    /// `AlignedEndTime` will be greater than or equal to the value of the
    /// user-specified `Endtime`.
    aligned_end_time: ?i64 = null,

    /// The start time for the returned metrics, after alignment to a granular
    /// boundary (as specified by `PeriodInSeconds`).
    /// `AlignedStartTime` will be less than or equal to the value of the
    /// user-specified `StartTime`.
    aligned_start_time: ?i64 = null,

    /// An immutable identifier for a data source that is unique for an Amazon Web
    /// Services Region. Performance Insights gathers metrics from this data source.
    /// In the
    /// console, the identifier is shown as *ResourceID*. When you call
    /// `DescribeDBInstances`, the identifier is
    /// returned as `DbiResourceId`.
    identifier: ?[]const u8 = null,

    /// An array of metric results, where each array element contains all of the
    /// data points for a
    /// particular dimension.
    metric_list: ?[]const MetricKeyDataPoints = null,

    /// An optional pagination token provided by a previous request. If this
    /// parameter is specified,
    /// the response includes only records beyond the token, up to the value
    /// specified by `MaxRecords`.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .aligned_end_time = "AlignedEndTime",
        .aligned_start_time = "AlignedStartTime",
        .identifier = "Identifier",
        .metric_list = "MetricList",
        .next_token = "NextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetResourceMetricsInput, options: CallOptions) !GetResourceMetricsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "pi");

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetResourceMetricsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("pi", "PI", allocator);

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
    try request.headers.put(allocator, "X-Amz-Target", "PerformanceInsightsv20180227.GetResourceMetrics");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetResourceMetricsOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(GetResourceMetricsOutput, body, allocator);
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

    if (std.mem.eql(u8, error_code, "InternalServiceError")) {
        return .{ .arena = arena, .kind = .{ .internal_service_error = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidArgumentException")) {
        return .{ .arena = arena, .kind = .{ .invalid_argument_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "NotAuthorizedException")) {
        return .{ .arena = arena, .kind = .{ .not_authorized_exception = .{
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
