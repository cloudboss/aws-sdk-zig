const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const BotAnalyzerHistorySummary = @import("bot_analyzer_history_summary.zig").BotAnalyzerHistorySummary;

pub const ListBotAnalyzerHistoryInput = struct {
    /// The unique identifier of the bot.
    bot_id: []const u8,

    /// The bot version to filter the history. If not specified, defaults to
    /// `DRAFT`.
    bot_version: ?[]const u8 = null,

    /// The locale identifier to filter the history. If not specified, returns
    /// history for all locales.
    locale_id: ?[]const u8 = null,

    /// The maximum number of history entries to return in the response. The default
    /// is 10.
    max_results: ?i32 = null,

    /// If the response from a previous request was truncated, the `nextToken` value
    /// is used to retrieve the next page of history entries.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .bot_id = "botId",
        .bot_version = "botVersion",
        .locale_id = "localeId",
        .max_results = "maxResults",
        .next_token = "nextToken",
    };
};

pub const ListBotAnalyzerHistoryOutput = struct {
    /// A list of historical analysis executions, ordered by creation date with the
    /// most recent first.
    bot_analyzer_history_list: ?[]const BotAnalyzerHistorySummary = null,

    /// The unique identifier of the bot.
    bot_id: ?[]const u8 = null,

    /// The bot version used to filter the history.
    bot_version: ?[]const u8 = null,

    /// The locale identifier used to filter the history.
    locale_id: ?[]const u8 = null,

    /// If the response is truncated, this token can be used in a subsequent request
    /// to retrieve the next page of history entries.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .bot_analyzer_history_list = "botAnalyzerHistoryList",
        .bot_id = "botId",
        .bot_version = "botVersion",
        .locale_id = "localeId",
        .next_token = "nextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListBotAnalyzerHistoryInput, options: CallOptions) !ListBotAnalyzerHistoryOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ListBotAnalyzerHistoryInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("models-v2-lex", "Lex Models V2", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/bots/");
    try path_buf.appendSlice(allocator, input.bot_id);
    try path_buf.appendSlice(allocator, "/botanalyzer/history");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.bot_version) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"botVersion\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.locale_id) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"localeId\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListBotAnalyzerHistoryOutput {
    const result: ListBotAnalyzerHistoryOutput = try aws.json.parseJsonObject(
        ListBotAnalyzerHistoryOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
