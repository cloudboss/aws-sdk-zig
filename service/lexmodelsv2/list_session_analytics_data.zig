const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AnalyticsSessionFilter = @import("analytics_session_filter.zig").AnalyticsSessionFilter;
const SessionDataSortBy = @import("session_data_sort_by.zig").SessionDataSortBy;
const SessionSpecification = @import("session_specification.zig").SessionSpecification;

pub const ListSessionAnalyticsDataInput = struct {
    /// The identifier for the bot for which you want to retrieve session analytics.
    bot_id: []const u8,

    /// The date and time that marks the end of the range of time for which you want
    /// to see session analytics.
    end_date_time: i64,

    /// A list of objects, each of which describes a condition by which you want to
    /// filter the results.
    filters: ?[]const AnalyticsSessionFilter = null,

    /// The maximum number of results to return in each page of results. If there
    /// are fewer results than the maximum page size, only the actual number of
    /// results are returned.
    max_results: ?i32 = null,

    /// If the response from the ListSessionAnalyticsData operation contains more
    /// results than specified in the maxResults parameter, a token is returned in
    /// the response.
    ///
    /// Use the returned token in the nextToken parameter of a
    /// ListSessionAnalyticsData request to return the next page of results. For a
    /// complete set of results, call the ListSessionAnalyticsData operation until
    /// the nextToken returned in the response is null.
    next_token: ?[]const u8 = null,

    /// An object specifying the measure and method by which to sort the session
    /// analytics data.
    sort_by: ?SessionDataSortBy = null,

    /// The date and time that marks the beginning of the range of time for which
    /// you want to see session analytics.
    start_date_time: i64,

    pub const json_field_names = .{
        .bot_id = "botId",
        .end_date_time = "endDateTime",
        .filters = "filters",
        .max_results = "maxResults",
        .next_token = "nextToken",
        .sort_by = "sortBy",
        .start_date_time = "startDateTime",
    };
};

pub const ListSessionAnalyticsDataOutput = struct {
    /// The unique identifier of the bot that the sessions belong to.
    bot_id: ?[]const u8 = null,

    /// If the response from the ListSessionAnalyticsData operation contains more
    /// results than specified in the maxResults parameter, a token is returned in
    /// the response.
    ///
    /// Use the returned token in the nextToken parameter of a
    /// ListSessionAnalyticsData request to return the next page of results. For a
    /// complete set of results, call the ListSessionAnalyticsData operation until
    /// the nextToken returned in the response is null.
    next_token: ?[]const u8 = null,

    /// A list of objects, each of which contains information about a session with
    /// the bot.
    sessions: ?[]const SessionSpecification = null,

    pub const json_field_names = .{
        .bot_id = "botId",
        .next_token = "nextToken",
        .sessions = "sessions",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListSessionAnalyticsDataInput, options: CallOptions) !ListSessionAnalyticsDataOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "lex", client.config.http_client.clock_skew_offset);

    var response = try client.config.http_client.sendRequestWithOptions(&request, client.options);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = try parseErrorResponse(client.allocator, response.body, response.status);
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: ListSessionAnalyticsDataInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("models-v2-lex", "Lex Models V2", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/bots/");
    try path_buf.appendSlice(allocator, input.bot_id);
    try path_buf.appendSlice(allocator, "/analytics/sessions");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

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
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"startDateTime\":");
    try aws.json.writeValue(@TypeOf(input.start_date_time), input.start_date_time, allocator, &body_buf);
    has_prev = true;

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListSessionAnalyticsDataOutput {
    const result: ListSessionAnalyticsDataOutput = try aws.json.parseJsonObject(
        ListSessionAnalyticsDataOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
