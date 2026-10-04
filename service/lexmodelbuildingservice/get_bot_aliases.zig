const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const BotAliasMetadata = @import("bot_alias_metadata.zig").BotAliasMetadata;

pub const GetBotAliasesInput = struct {
    /// The name of the bot.
    bot_name: []const u8,

    /// The maximum number of aliases to return in the response. The
    /// default is 50. .
    max_results: ?i32 = null,

    /// Substring to match in bot alias names. An alias will be returned if
    /// any part of its name matches the substring. For example, "xyz" matches
    /// both "xyzabc" and "abcxyz."
    name_contains: ?[]const u8 = null,

    /// A pagination token for fetching the next page of aliases. If the
    /// response to this call is truncated, Amazon Lex returns a pagination token in
    /// the response. To fetch the next page of aliases, specify the pagination
    /// token in the next request.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .bot_name = "botName",
        .max_results = "maxResults",
        .name_contains = "nameContains",
        .next_token = "nextToken",
    };
};

pub const GetBotAliasesOutput = struct {
    /// An array of `BotAliasMetadata` objects, each describing
    /// a bot alias.
    bot_aliases: ?[]const BotAliasMetadata = null,

    /// A pagination token for fetching next page of aliases. If the
    /// response to this call is truncated, Amazon Lex returns a pagination token in
    /// the response. To fetch the next page of aliases, specify the pagination
    /// token in the next request.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .bot_aliases = "BotAliases",
        .next_token = "nextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetBotAliasesInput, options: CallOptions) !GetBotAliasesOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetBotAliasesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("models.lex", "Lex Model Building Service", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/bots/");
    try path_buf.appendSlice(allocator, input.bot_name);
    try path_buf.appendSlice(allocator, "/aliases");
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.max_results) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "maxResults=");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try query_buf.appendSlice(allocator, num_str);
        }
        query_has_prev = true;
    }
    if (input.name_contains) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "nameContains=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    if (input.next_token) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "nextToken=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    const query = try query_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    request.query = query;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetBotAliasesOutput {
    const result: GetBotAliasesOutput = try aws.json.parseJsonObject(
        GetBotAliasesOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
