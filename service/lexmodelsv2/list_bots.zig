const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const BotFilter = @import("bot_filter.zig").BotFilter;
const BotSortBy = @import("bot_sort_by.zig").BotSortBy;
const BotSummary = @import("bot_summary.zig").BotSummary;

pub const ListBotsInput = struct {
    /// Provides the specification of a filter used to limit the bots in the
    /// response to only those that match the filter specification. You can
    /// only specify one filter and one string to filter on.
    filters: ?[]const BotFilter = null,

    /// The maximum number of bots to return in each page of results. If
    /// there are fewer results than the maximum page size, only the actual
    /// number of results are returned.
    max_results: ?i32 = null,

    /// If the response from the `ListBots` operation contains
    /// more results than specified in the `maxResults` parameter, a
    /// token is returned in the response.
    ///
    /// Use the returned token in the `nextToken` parameter of a
    /// `ListBots` request to return the next page of results.
    /// For a complete set of results, call the `ListBots` operation
    /// until the `nextToken` returned in the response is
    /// null.
    next_token: ?[]const u8 = null,

    /// Specifies sorting parameters for the list of bots. You can specify
    /// that the list be sorted by bot name in ascending or descending
    /// order.
    sort_by: ?BotSortBy = null,

    pub const json_field_names = .{
        .filters = "filters",
        .max_results = "maxResults",
        .next_token = "nextToken",
        .sort_by = "sortBy",
    };
};

pub const ListBotsOutput = struct {
    /// Summary information for the bots that meet the filter criteria
    /// specified in the request. The length of the list is specified in the
    /// `maxResults` parameter of the request. If there are more
    /// bots available, the `nextToken` field contains a token to
    /// the next page of results.
    bot_summaries: ?[]const BotSummary = null,

    /// A token that indicates whether there are more results to return in a
    /// response to the `ListBots` operation. If the
    /// `nextToken` field is present, you send the contents as
    /// the `nextToken` parameter of a `ListBots`
    /// operation request to get the next page of results.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .bot_summaries = "botSummaries",
        .next_token = "nextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListBotsInput, options: CallOptions) !ListBotsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ListBotsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("models-v2-lex", "Lex Models V2", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/bots";

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListBotsOutput {
    const result: ListBotsOutput = try aws.json.parseJsonObject(
        ListBotsOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
