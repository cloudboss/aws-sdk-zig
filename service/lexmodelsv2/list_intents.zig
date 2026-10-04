const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const IntentFilter = @import("intent_filter.zig").IntentFilter;
const IntentSortBy = @import("intent_sort_by.zig").IntentSortBy;
const IntentSummary = @import("intent_summary.zig").IntentSummary;

pub const ListIntentsInput = struct {
    /// The unique identifier of the bot that contains the intent.
    bot_id: []const u8,

    /// The version of the bot that contains the intent.
    bot_version: []const u8,

    /// Provides the specification of a filter used to limit the intents in
    /// the response to only those that match the filter specification. You can
    /// only specify one filter and only one string to filter on.
    filters: ?[]const IntentFilter = null,

    /// The identifier of the language and locale of the intents to list.
    /// The string must match one of the supported locales. For more
    /// information, see [Supported
    /// languages](https://docs.aws.amazon.com/lexv2/latest/dg/how-languages.html).
    locale_id: []const u8,

    /// The maximum number of intents to return in each page of results. If
    /// there are fewer results than the max page size, only the actual number
    /// of results are returned.
    max_results: ?i32 = null,

    /// If the response from the `ListIntents` operation contains
    /// more results than specified in the `maxResults` parameter, a
    /// token is returned in the response.
    ///
    /// Use the returned token in the `nextToken` parameter of a
    /// `ListIntents` request to return the next page of results.
    /// For a complete set of results, call the `ListIntents`
    /// operation until the `nextToken` returned in the response is
    /// null.
    next_token: ?[]const u8 = null,

    /// Determines the sort order for the response from the
    /// `ListIntents` operation. You can choose to sort by the
    /// intent name or last updated date in either ascending or descending
    /// order.
    sort_by: ?IntentSortBy = null,

    pub const json_field_names = .{
        .bot_id = "botId",
        .bot_version = "botVersion",
        .filters = "filters",
        .locale_id = "localeId",
        .max_results = "maxResults",
        .next_token = "nextToken",
        .sort_by = "sortBy",
    };
};

pub const ListIntentsOutput = struct {
    /// The identifier of the bot that contains the intent.
    bot_id: ?[]const u8 = null,

    /// The version of the bot that contains the intent.
    bot_version: ?[]const u8 = null,

    /// Summary information for the intents that meet the filter criteria
    /// specified in the request. The length of the list is specified in the
    /// `maxResults` parameter of the request. If there are more
    /// intents available, the `nextToken` field contains a token to
    /// get the next page of results.
    intent_summaries: ?[]const IntentSummary = null,

    /// The language and locale of the intents in the list.
    locale_id: ?[]const u8 = null,

    /// A token that indicates whether there are more results to return in a
    /// response to the `ListIntents` operation. If the
    /// `nextToken` field is present, you send the contents as
    /// the `nextToken` parameter of a `ListIntents`
    /// operation request to get the next page of results.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .bot_id = "botId",
        .bot_version = "botVersion",
        .intent_summaries = "intentSummaries",
        .locale_id = "localeId",
        .next_token = "nextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListIntentsInput, options: CallOptions) !ListIntentsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ListIntentsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("models-v2-lex", "Lex Models V2", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/bots/");
    try path_buf.appendSlice(allocator, input.bot_id);
    try path_buf.appendSlice(allocator, "/botversions/");
    try path_buf.appendSlice(allocator, input.bot_version);
    try path_buf.appendSlice(allocator, "/botlocales/");
    try path_buf.appendSlice(allocator, input.locale_id);
    try path_buf.appendSlice(allocator, "/intents");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListIntentsOutput {
    var result: ListIntentsOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(ListIntentsOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
