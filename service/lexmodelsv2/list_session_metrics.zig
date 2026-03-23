const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const AnalyticsBinBySpecification = @import("analytics_bin_by_specification.zig").AnalyticsBinBySpecification;
const AnalyticsSessionFilter = @import("analytics_session_filter.zig").AnalyticsSessionFilter;
const AnalyticsSessionGroupBySpecification = @import("analytics_session_group_by_specification.zig").AnalyticsSessionGroupBySpecification;
const AnalyticsSessionMetric = @import("analytics_session_metric.zig").AnalyticsSessionMetric;
const AnalyticsSessionResult = @import("analytics_session_result.zig").AnalyticsSessionResult;

pub const ListSessionMetricsInput = struct {
    /// A list of objects, each of which contains specifications for organizing the
    /// results by time.
    bin_by: ?[]const AnalyticsBinBySpecification = null,

    /// The identifier for the bot for which you want to retrieve session metrics.
    bot_id: []const u8,

    /// The date and time that marks the end of the range of time for which you want
    /// to see session metrics.
    end_date_time: i64,

    /// A list of objects, each of which describes a condition by which you want to
    /// filter the results.
    filters: ?[]const AnalyticsSessionFilter = null,

    /// A list of objects, each of which specifies how to group the results. You can
    /// group by the following criteria:
    ///
    /// * `ConversationEndState` – The final state of the conversation. The possible
    ///   end states are detailed in [Key
    ///   definitions](https://docs.aws.amazon.com/analytics-key-definitions-conversations) in the user guide.
    ///
    /// * `LocaleId` – The unique identifier of the bot locale.
    group_by: ?[]const AnalyticsSessionGroupBySpecification = null,

    /// The maximum number of results to return in each page of results. If there
    /// are fewer results than the maximum page size, only the actual number of
    /// results are returned.
    max_results: ?i32 = null,

    /// A list of objects, each of which contains a metric you want to list, the
    /// statistic for the metric you want to return, and the method by which to
    /// organize the results.
    metrics: []const AnalyticsSessionMetric,

    /// If the response from the ListSessionMetrics operation contains more results
    /// than specified in the maxResults parameter, a token is returned in the
    /// response.
    ///
    /// Use the returned token in the nextToken parameter of a ListSessionMetrics
    /// request to return the next page of results. For a complete set of results,
    /// call the ListSessionMetrics operation until the nextToken returned in the
    /// response is null.
    next_token: ?[]const u8 = null,

    /// The date and time that marks the beginning of the range of time for which
    /// you want to see session metrics.
    start_date_time: i64,

    pub const json_field_names = .{
        .bin_by = "binBy",
        .bot_id = "botId",
        .end_date_time = "endDateTime",
        .filters = "filters",
        .group_by = "groupBy",
        .max_results = "maxResults",
        .metrics = "metrics",
        .next_token = "nextToken",
        .start_date_time = "startDateTime",
    };
};

pub const ListSessionMetricsOutput = struct {
    /// The identifier for the bot for which you retrieved session metrics.
    bot_id: ?[]const u8 = null,

    /// If the response from the ListSessionMetrics operation contains more results
    /// than specified in the maxResults parameter, a token is returned in the
    /// response.
    ///
    /// Use the returned token in the nextToken parameter of a ListSessionMetrics
    /// request to return the next page of results. For a complete set of results,
    /// call the ListSessionMetrics operation until the nextToken returned in the
    /// response is null.
    next_token: ?[]const u8 = null,

    /// The results for the session metrics.
    results: ?[]const AnalyticsSessionResult = null,

    pub const json_field_names = .{
        .bot_id = "botId",
        .next_token = "nextToken",
        .results = "results",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListSessionMetricsInput, options: CallOptions) !ListSessionMetricsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "lex");

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListSessionMetricsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("models-v2-lex", "Lex Models V2", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var path_buf: std.ArrayList(u8) = .{};
    try path_buf.appendSlice(allocator, "/bots/");
    try path_buf.appendSlice(allocator, input.bot_id);
    try path_buf.appendSlice(allocator, "/analytics/sessionmetrics");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .{};
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.bin_by) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"binBy\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"endDateTime\":");
    try aws.json.writeValue(@TypeOf(input.end_date_time), input.end_date_time, allocator, &body_buf);
    has_prev = true;
    if (input.filters) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"filters\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.group_by) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"groupBy\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.max_results) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"maxResults\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"metrics\":");
    try aws.json.writeValue(@TypeOf(input.metrics), input.metrics, allocator, &body_buf);
    has_prev = true;
    if (input.next_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"nextToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"startDateTime\":");
    try aws.json.writeValue(@TypeOf(input.start_date_time), input.start_date_time, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListSessionMetricsOutput {
    var result: ListSessionMetricsOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(ListSessionMetricsOutput, body, allocator);
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

    if (std.mem.eql(u8, error_code, "ConflictException")) {
        return .{ .arena = arena, .kind = .{ .conflict_exception = .{
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
    if (std.mem.eql(u8, error_code, "PreconditionFailedException")) {
        return .{ .arena = arena, .kind = .{ .precondition_failed_exception = .{
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
    if (std.mem.eql(u8, error_code, "ServiceQuotaExceededException")) {
        return .{ .arena = arena, .kind = .{ .service_quota_exceeded_exception = .{
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
