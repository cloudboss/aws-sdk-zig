const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const SessionState = @import("session_state.zig").SessionState;
const Interpretation = @import("interpretation.zig").Interpretation;
const Message = @import("message.zig").Message;
const RecognizedBotMember = @import("recognized_bot_member.zig").RecognizedBotMember;

pub const RecognizeTextInput = struct {
    /// The alias identifier in use for the bot that processes the
    /// request.
    bot_alias_id: []const u8,

    /// The identifier of the bot that processes the request.
    bot_id: []const u8,

    /// The locale where the session is in use.
    locale_id: []const u8,

    /// Request-specific information passed between the client application
    /// and Amazon Lex V2
    ///
    /// The namespace `x-amz-lex:` is reserved for special
    /// attributes. Don't create any request attributes with the prefix
    /// `x-amz-lex:`.
    request_attributes: ?[]const aws.map.StringMapEntry = null,

    /// The identifier of the user session that is having the
    /// conversation.
    session_id: []const u8,

    /// The current state of the dialog between the user and the bot.
    session_state: ?SessionState = null,

    /// The text that the user entered. Amazon Lex V2 interprets this text.
    text: []const u8,

    pub const json_field_names = .{
        .bot_alias_id = "botAliasId",
        .bot_id = "botId",
        .locale_id = "localeId",
        .request_attributes = "requestAttributes",
        .session_id = "sessionId",
        .session_state = "sessionState",
        .text = "text",
    };
};

pub const RecognizeTextOutput = struct {
    /// A list of intents that Amazon Lex V2 determined might satisfy the user's
    /// utterance.
    ///
    /// Each interpretation includes the intent, a score that indicates now
    /// confident Amazon Lex V2 is that the interpretation is the correct one, and
    /// an
    /// optional sentiment response that indicates the sentiment expressed in
    /// the utterance.
    interpretations: ?[]const Interpretation = null,

    /// A list of messages last sent to the user. The messages are ordered
    /// based on the order that you returned the messages from your Lambda
    /// function or the order that the messages are defined in the bot.
    messages: ?[]const Message = null,

    /// The bot member that recognized the text.
    recognized_bot_member: ?RecognizedBotMember = null,

    /// The attributes sent in the request.
    request_attributes: ?[]const aws.map.StringMapEntry = null,

    /// The identifier of the session in use.
    session_id: ?[]const u8 = null,

    /// Represents the current state of the dialog between the user and the
    /// bot.
    ///
    /// Use this to determine the progress of the conversation and what the
    /// next action may be.
    session_state: ?SessionState = null,

    pub const json_field_names = .{
        .interpretations = "interpretations",
        .messages = "messages",
        .recognized_bot_member = "recognizedBotMember",
        .request_attributes = "requestAttributes",
        .session_id = "sessionId",
        .session_state = "sessionState",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: RecognizeTextInput, options: CallOptions) !RecognizeTextOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: RecognizeTextInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("runtime-v2-lex", "Lex Runtime V2", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var path_buf: std.ArrayList(u8) = .{};
    try path_buf.appendSlice(allocator, "/bots/");
    try path_buf.appendSlice(allocator, input.bot_id);
    try path_buf.appendSlice(allocator, "/botAliases/");
    try path_buf.appendSlice(allocator, input.bot_alias_id);
    try path_buf.appendSlice(allocator, "/botLocales/");
    try path_buf.appendSlice(allocator, input.locale_id);
    try path_buf.appendSlice(allocator, "/sessions/");
    try path_buf.appendSlice(allocator, input.session_id);
    try path_buf.appendSlice(allocator, "/text");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .{};
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.request_attributes) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"requestAttributes\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.session_state) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"sessionState\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"text\":");
    try aws.json.writeValue(@TypeOf(input.text), input.text, allocator, &body_buf);
    has_prev = true;

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !RecognizeTextOutput {
    var result: RecognizeTextOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(RecognizeTextOutput, body, allocator);
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

    if (std.mem.eql(u8, error_code, "AccessDeniedException")) {
        return .{ .arena = arena, .kind = .{ .access_denied_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "BadGatewayException")) {
        return .{ .arena = arena, .kind = .{ .bad_gateway_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ConflictException")) {
        return .{ .arena = arena, .kind = .{ .conflict_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "DependencyFailedException")) {
        return .{ .arena = arena, .kind = .{ .dependency_failed_exception = .{
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
    if (std.mem.eql(u8, error_code, "ResourceNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .resource_not_found_exception = .{
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
