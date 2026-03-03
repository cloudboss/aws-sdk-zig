const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const FilterParameter = @import("filter_parameter.zig").FilterParameter;
const QueryType = @import("query_type.zig").QueryType;

pub const StartQueryInput = struct {
    /// The timestamp that is the end of the period that you want to retrieve data
    /// for with your query.
    end_time: i64,

    /// The `FilterParameters` field that you use with Amazon CloudWatch Internet
    /// Monitor queries is a string the defines
    /// how you want a query to be filtered. The filter parameters that you can
    /// specify depend on the query type, since
    /// each query type returns a different set of Internet Monitor data.
    ///
    /// For more information about specifying filter parameters, see
    /// [Using the Amazon CloudWatch Internet Monitor query
    /// interface](https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/CloudWatch-IM-view-cw-tools-cwim-query.html)
    /// in the Amazon CloudWatch Internet Monitor User Guide.
    filter_parameters: ?[]const FilterParameter = null,

    /// The account ID for an account that you've set up cross-account sharing for
    /// in Amazon CloudWatch Internet Monitor. You configure cross-account
    /// sharing by using Amazon CloudWatch Observability Access Manager. For more
    /// information, see
    /// [Internet Monitor cross-account
    /// observability](https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/cwim-cross-account.html) in the Amazon CloudWatch Internet Monitor User Guide.
    linked_account_id: ?[]const u8 = null,

    /// The name of the monitor to query.
    monitor_name: []const u8,

    /// The type of query to run. The following are the three types of queries that
    /// you can run using the Internet Monitor query interface:
    ///
    /// * `MEASUREMENTS`: Provides availability score, performance score, total
    ///   traffic,
    /// and round-trip times, at 5 minute intervals.
    ///
    /// * `TOP_LOCATIONS`: Provides availability score, performance score, total
    ///   traffic,
    /// and time to first byte (TTFB) information, for the top location and ASN
    /// combinations that you're monitoring, by traffic volume.
    ///
    /// * `TOP_LOCATION_DETAILS`: Provides TTFB for Amazon CloudFront, your
    /// current configuration, and the best performing EC2 configuration, at 1 hour
    /// intervals.
    ///
    /// * `OVERALL_TRAFFIC_SUGGESTIONS`: Provides TTFB, using a 30-day weighted
    ///   average, for all traffic in
    /// each Amazon Web Services location that is monitored.
    ///
    /// * `OVERALL_TRAFFIC_SUGGESTIONS_DETAILS`: Provides TTFB, using a 30-day
    ///   weighted average, for each top
    /// location, for a proposed Amazon Web Services location. Must provide an
    /// Amazon Web Services location to search.
    ///
    /// * `ROUTING_SUGGESTIONS`: Provides the predicted average round-trip time
    ///   (RTT) from an IP prefix toward
    /// an Amazon Web Services location for a DNS resolver. The RTT is calculated at
    /// one hour intervals, over a one hour period.
    ///
    /// For lists of the fields returned with each query type and more information
    /// about how each type of query is
    /// performed, see [
    /// Using the Amazon CloudWatch Internet Monitor query
    /// interface](https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/CloudWatch-IM-view-cw-tools-cwim-query.html) in the Amazon CloudWatch Internet Monitor User Guide.
    query_type: QueryType,

    /// The timestamp that is the beginning of the period that you want to retrieve
    /// data for with your query.
    start_time: i64,

    pub const json_field_names = .{
        .end_time = "EndTime",
        .filter_parameters = "FilterParameters",
        .linked_account_id = "LinkedAccountId",
        .monitor_name = "MonitorName",
        .query_type = "QueryType",
        .start_time = "StartTime",
    };
};

pub const StartQueryOutput = struct {
    /// The internally-generated identifier of a specific query.
    query_id: []const u8,

    pub const json_field_names = .{
        .query_id = "QueryId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: StartQueryInput, options: CallOptions) !StartQueryOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "internetmonitor");

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

fn serializeRequest(allocator: std.mem.Allocator, input: StartQueryInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("internetmonitor", "InternetMonitor", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var path_buf: std.ArrayList(u8) = .{};
    try path_buf.appendSlice(allocator, "/v20210603/Monitors/");
    try path_buf.appendSlice(allocator, input.monitor_name);
    try path_buf.appendSlice(allocator, "/Queries");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .{};
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"EndTime\":");
    try aws.json.writeValue(@TypeOf(input.end_time), input.end_time, allocator, &body_buf);
    has_prev = true;
    if (input.filter_parameters) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"FilterParameters\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.linked_account_id) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"LinkedAccountId\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"QueryType\":");
    try aws.json.writeValue(@TypeOf(input.query_type), input.query_type, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"StartTime\":");
    try aws.json.writeValue(@TypeOf(input.start_time), input.start_time, allocator, &body_buf);
    has_prev = true;

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !StartQueryOutput {
    var result: StartQueryOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(StartQueryOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
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
    if (std.mem.eql(u8, error_code, "BadRequestException")) {
        return .{ .arena = arena, .kind = .{ .bad_request_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ConflictException")) {
        return .{ .arena = arena, .kind = .{ .conflict_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InternalServerErrorException")) {
        return .{ .arena = arena, .kind = .{ .internal_server_error_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InternalServerException")) {
        return .{ .arena = arena, .kind = .{ .internal_server_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "LimitExceededException")) {
        return .{ .arena = arena, .kind = .{ .limit_exceeded_exception = .{
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
    if (std.mem.eql(u8, error_code, "ResourceNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .resource_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ThrottlingException")) {
        return .{ .arena = arena, .kind = .{ .throttling_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TooManyRequestsException")) {
        return .{ .arena = arena, .kind = .{ .too_many_requests_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ValidationException")) {
        return .{ .arena = arena, .kind = .{ .validation_exception = .{
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
