const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ConversationLogsResponse = @import("conversation_logs_response.zig").ConversationLogsResponse;

pub const GetBotAliasInput = struct {
    /// The name of the bot.
    bot_name: []const u8,

    /// The name of the bot alias. The name is case sensitive.
    name: []const u8,

    pub const json_field_names = .{
        .bot_name = "botName",
        .name = "name",
    };
};

pub const GetBotAliasOutput = struct {
    /// The name of the bot that the alias points to.
    bot_name: ?[]const u8 = null,

    /// The version of the bot that the alias points to.
    bot_version: ?[]const u8 = null,

    /// Checksum of the bot alias.
    checksum: ?[]const u8 = null,

    /// The settings that determine how Amazon Lex uses conversation logs for the
    /// alias.
    conversation_logs: ?ConversationLogsResponse = null,

    /// The date that the bot alias was created.
    created_date: ?i64 = null,

    /// A description of the bot alias.
    description: ?[]const u8 = null,

    /// The date that the bot alias was updated. When you create a
    /// resource, the creation date and the last updated date are the
    /// same.
    last_updated_date: ?i64 = null,

    /// The name of the bot alias.
    name: ?[]const u8 = null,

    pub const json_field_names = .{
        .bot_name = "botName",
        .bot_version = "botVersion",
        .checksum = "checksum",
        .conversation_logs = "conversationLogs",
        .created_date = "createdDate",
        .description = "description",
        .last_updated_date = "lastUpdatedDate",
        .name = "name",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetBotAliasInput, options: CallOptions) !GetBotAliasOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetBotAliasInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("models.lex", "Lex Model Building Service", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/bots/");
    try path_buf.appendSlice(allocator, input.bot_name);
    try path_buf.appendSlice(allocator, "/aliases/");
    try path_buf.appendSlice(allocator, input.name);
    const path = try path_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetBotAliasOutput {
    const result: GetBotAliasOutput = try aws.json.parseJsonObject(
        GetBotAliasOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
