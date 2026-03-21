const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const UtteranceAggregationDuration = @import("utterance_aggregation_duration.zig").UtteranceAggregationDuration;
const AggregatedUtterancesFilter = @import("aggregated_utterances_filter.zig").AggregatedUtterancesFilter;
const AggregatedUtterancesSortBy = @import("aggregated_utterances_sort_by.zig").AggregatedUtterancesSortBy;
const AggregatedUtterancesSummary = @import("aggregated_utterances_summary.zig").AggregatedUtterancesSummary;

pub const ListAggregatedUtterancesInput = struct {
    /// The time window for aggregating the utterance information. You can
    /// specify a time between one hour and two weeks.
    aggregation_duration: UtteranceAggregationDuration,

    /// The identifier of the bot alias associated with this request. If you
    /// specify the bot alias, you can't specify the bot version.
    bot_alias_id: ?[]const u8 = null,

    /// The unique identifier of the bot associated with this
    /// request.
    bot_id: []const u8,

    /// The identifier of the bot version associated with this request. If
    /// you specify the bot version, you can't specify the bot alias.
    bot_version: ?[]const u8 = null,

    /// Provides the specification of a filter used to limit the utterances
    /// in the response to only those that match the filter specification. You
    /// can only specify one filter and one string to filter on.
    filters: ?[]const AggregatedUtterancesFilter = null,

    /// The identifier of the language and locale where the utterances were
    /// collected. For more information, see [Supported
    /// languages](https://docs.aws.amazon.com/lexv2/latest/dg/how-languages.html).
    locale_id: []const u8,

    /// The maximum number of utterances to return in each page of results.
    /// If there are fewer results than the maximum page size, only the actual
    /// number of results are returned. If you don't specify the
    /// `maxResults` parameter, 1,000 results are
    /// returned.
    max_results: ?i32 = null,

    /// If the response from the `ListAggregatedUtterances`
    /// operation contains more results that specified in the
    /// `maxResults` parameter, a token is returned in the
    /// response. Use that token in the `nextToken` parameter to
    /// return the next page of results.
    next_token: ?[]const u8 = null,

    /// Specifies sorting parameters for the list of utterances. You can
    /// sort by the hit count, the missed count, or the number of distinct
    /// sessions the utterance appeared in.
    sort_by: ?AggregatedUtterancesSortBy = null,

    pub const json_field_names = .{
        .aggregation_duration = "aggregationDuration",
        .bot_alias_id = "botAliasId",
        .bot_id = "botId",
        .bot_version = "botVersion",
        .filters = "filters",
        .locale_id = "localeId",
        .max_results = "maxResults",
        .next_token = "nextToken",
        .sort_by = "sortBy",
    };
};

pub const ListAggregatedUtterancesOutput = struct {
    /// Summaries of the aggregated utterance data. Each response contains
    /// information about the number of times that the utterance was seen
    /// during the time period, whether it was detected or missed, and when it
    /// was seen during the time period.
    aggregated_utterances_summaries: ?[]const AggregatedUtterancesSummary = null,

    /// The time period used to aggregate the utterance data.
    aggregation_duration: ?UtteranceAggregationDuration = null,

    /// The last date and time that the aggregated data was collected. The
    /// time period depends on the length of the aggregation window.
    ///
    /// * **Hours** - for 1 hour time
    /// window, every half hour; otherwise every hour.
    ///
    /// * **Days** - every 6 hours
    ///
    /// * **Weeks** - for a one week time
    /// window, every 12 hours; otherwise, every day
    aggregation_last_refreshed_date_time: ?i64 = null,

    /// The date and time that the aggregation window ends. Only data
    /// collected between the start time and the end time are returned in the
    /// results.
    aggregation_window_end_time: ?i64 = null,

    /// The date and time that the aggregation window begins. Only data
    /// collected after this time is returned in the results.
    aggregation_window_start_time: ?i64 = null,

    /// The identifier of the bot alias that contains the utterances. If you
    /// specified the bot version, the bot alias ID isn't returned.
    bot_alias_id: ?[]const u8 = null,

    /// The identifier of the bot that contains the utterances.
    bot_id: ?[]const u8 = null,

    /// The identifier of the bot version that contains the utterances. If
    /// you specified the bot alias, the bot version isn't returned.
    bot_version: ?[]const u8 = null,

    /// The identifier of the language and locale that the utterances are
    /// in.
    locale_id: ?[]const u8 = null,

    /// A token that indicates whether there are more results to return in a
    /// response to the `ListAggregatedUtterances` operation. If the
    /// `nextToken` field is present, you send the contents as
    /// the `nextToken` parameter of a
    /// `ListAggregatedUtterances` operation request to get the
    /// next page of results.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .aggregated_utterances_summaries = "aggregatedUtterancesSummaries",
        .aggregation_duration = "aggregationDuration",
        .aggregation_last_refreshed_date_time = "aggregationLastRefreshedDateTime",
        .aggregation_window_end_time = "aggregationWindowEndTime",
        .aggregation_window_start_time = "aggregationWindowStartTime",
        .bot_alias_id = "botAliasId",
        .bot_id = "botId",
        .bot_version = "botVersion",
        .locale_id = "localeId",
        .next_token = "nextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListAggregatedUtterancesInput, options: CallOptions) !ListAggregatedUtterancesOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
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

fn serializeRequest(allocator: std.mem.Allocator, input: ListAggregatedUtterancesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("models-v2-lex", "Lex Models V2", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var path_buf: std.ArrayList(u8) = .{};
    try path_buf.appendSlice(allocator, "/bots/");
    try path_buf.appendSlice(allocator, input.bot_id);
    try path_buf.appendSlice(allocator, "/aggregatedutterances");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .{};
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"aggregationDuration\":");
    try aws.json.writeValue(@TypeOf(input.aggregation_duration), input.aggregation_duration, allocator, &body_buf);
    has_prev = true;
    if (input.bot_alias_id) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"botAliasId\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.bot_version) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"botVersion\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.filters) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"filters\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"localeId\":");
    try aws.json.writeValue(@TypeOf(input.locale_id), input.locale_id, allocator, &body_buf);
    has_prev = true;
    if (input.max_results) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"maxResults\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.next_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"nextToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.sort_by) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"sortBy\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListAggregatedUtterancesOutput {
    var result: ListAggregatedUtterancesOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(ListAggregatedUtterancesOutput, body, allocator);
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
