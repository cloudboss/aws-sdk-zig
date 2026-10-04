const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const DeleteSessionInput = struct {
    /// The alias identifier in use for the bot that contains the session
    /// data.
    bot_alias_id: []const u8,

    /// The identifier of the bot that contains the session data.
    bot_id: []const u8,

    /// The locale where the session is in use.
    locale_id: []const u8,

    /// The identifier of the session to delete.
    session_id: []const u8,

    pub const json_field_names = .{
        .bot_alias_id = "botAliasId",
        .bot_id = "botId",
        .locale_id = "localeId",
        .session_id = "sessionId",
    };
};

pub const DeleteSessionOutput = struct {
    /// The alias identifier in use for the bot that contained the session
    /// data.
    bot_alias_id: ?[]const u8 = null,

    /// The identifier of the bot that contained the session data.
    bot_id: ?[]const u8 = null,

    /// The locale where the session was used.
    locale_id: ?[]const u8 = null,

    /// The identifier of the deleted session.
    session_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .bot_alias_id = "botAliasId",
        .bot_id = "botId",
        .locale_id = "localeId",
        .session_id = "sessionId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DeleteSessionInput, options: CallOptions) !DeleteSessionOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DeleteSessionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("runtime-v2-lex", "Lex Runtime V2", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/bots/");
    try path_buf.appendSlice(allocator, input.bot_id);
    try path_buf.appendSlice(allocator, "/botAliases/");
    try path_buf.appendSlice(allocator, input.bot_alias_id);
    try path_buf.appendSlice(allocator, "/botLocales/");
    try path_buf.appendSlice(allocator, input.locale_id);
    try path_buf.appendSlice(allocator, "/sessions/");
    try path_buf.appendSlice(allocator, input.session_id);
    const path = try path_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .DELETE;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DeleteSessionOutput {
    var result: DeleteSessionOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(DeleteSessionOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
