const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const BotAliasSummary = @import("bot_alias_summary.zig").BotAliasSummary;

pub const ListBotAliasesInput = struct {
    /// The identifier of the bot to list aliases for.
    bot_id: []const u8,

    /// The maximum number of aliases to return in each page of results. If
    /// there are fewer results than the max page size, only the actual number
    /// of results are returned.
    max_results: ?i32 = null,

    /// If the response from the `ListBotAliases` operation
    /// contains more results than specified in the `maxResults`
    /// parameter, a token is returned in the response. Use that token in the
    /// `nextToken` parameter to return the next page of
    /// results.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .bot_id = "botId",
        .max_results = "maxResults",
        .next_token = "nextToken",
    };
};

pub const ListBotAliasesOutput = struct {
    /// Summary information for the bot aliases that meet the filter
    /// criteria specified in the request. The length of the list is specified
    /// in the `maxResults` parameter of the request. If there are
    /// more aliases available, the `nextToken` field contains a
    /// token to get the next page of results.
    bot_alias_summaries: ?[]const BotAliasSummary = null,

    /// The identifier of the bot associated with the aliases.
    bot_id: ?[]const u8 = null,

    /// A token that indicates whether there are more results to return in a
    /// response to the `ListBotAliases` operation. If the
    /// `nextToken` field is present, you send the contents as
    /// the `nextToken` parameter of a `ListBotAliases`
    /// operation request to get the next page of results.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .bot_alias_summaries = "botAliasSummaries",
        .bot_id = "botId",
        .next_token = "nextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListBotAliasesInput, options: CallOptions) !ListBotAliasesOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ListBotAliasesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("models-v2-lex", "Lex Models V2", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/bots/");
    try path_buf.appendSlice(allocator, input.bot_id);
    try path_buf.appendSlice(allocator, "/botaliases");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListBotAliasesOutput {
    var result: ListBotAliasesOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(ListBotAliasesOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
