const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Interpretation = @import("interpretation.zig").Interpretation;
const Message = @import("message.zig").Message;
const SessionState = @import("session_state.zig").SessionState;

pub const GetSessionInput = struct {
    /// The alias identifier in use for the bot that contains the session
    /// data.
    bot_alias_id: []const u8,

    /// The identifier of the bot that contains the session data.
    bot_id: []const u8,

    /// The locale where the session is in use.
    locale_id: []const u8,

    /// The identifier of the session to return.
    session_id: []const u8,

    pub const json_field_names = .{
        .bot_alias_id = "botAliasId",
        .bot_id = "botId",
        .locale_id = "localeId",
        .session_id = "sessionId",
    };
};

pub const GetSessionOutput = struct {
    /// A list of intents that Amazon Lex V2 determined might satisfy the user's
    /// utterance.
    ///
    /// Each interpretation includes the intent, a score that indicates how
    /// confident Amazon Lex V2 is that the interpretation is the correct one, and
    /// an
    /// optional sentiment response that indicates the sentiment expressed in
    /// the utterance.
    interpretations: ?[]const Interpretation = null,

    /// A list of messages that were last sent to the user. The messages are
    /// ordered based on the order that your returned the messages from your
    /// Lambda function or the order that messages are defined in the bot.
    messages: ?[]const Message = null,

    /// The identifier of the returned session.
    session_id: ?[]const u8 = null,

    /// Represents the current state of the dialog between the user and the
    /// bot.
    ///
    /// You can use this to determine the progress of the conversation and
    /// what the next action might be.
    session_state: ?SessionState = null,

    pub const json_field_names = .{
        .interpretations = "interpretations",
        .messages = "messages",
        .session_id = "sessionId",
        .session_state = "sessionState",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetSessionInput, options: CallOptions) !GetSessionOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetSessionInput, config: *aws.Config) !aws.http.Request {
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
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetSessionOutput {
    const result: GetSessionOutput = try aws.json.parseJsonObject(
        GetSessionOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
