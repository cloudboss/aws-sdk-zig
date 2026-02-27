const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const Message = @import("message.zig").Message;
const SessionState = @import("session_state.zig").SessionState;

pub const PutSessionInput = struct {
    /// The alias identifier of the bot that receives the session
    /// data.
    bot_alias_id: []const u8,

    /// The identifier of the bot that receives the session data.
    bot_id: []const u8,

    /// The locale where the session is in use.
    locale_id: []const u8,

    /// A list of messages to send to the user. Messages are sent in the
    /// order that they are defined in the list.
    messages: ?[]const Message = null,

    /// Request-specific information passed between Amazon Lex V2 and the client
    /// application.
    ///
    /// The namespace `x-amz-lex:` is reserved for special
    /// attributes. Don't create any request attributes with the prefix
    /// `x-amz-lex:`.
    request_attributes: ?[]const aws.map.StringMapEntry = null,

    /// The message that Amazon Lex V2 returns in the response can be either text or
    /// speech depending on the value of this parameter.
    ///
    /// * If the value is `text/plain; charset=utf-8`, Amazon Lex V2
    /// returns text in the response.
    response_content_type: ?[]const u8 = null,

    /// The identifier of the session that receives the session data.
    session_id: []const u8,

    /// Sets the state of the session with the user. You can use this to set
    /// the current intent, attributes, context, and dialog action. Use the
    /// dialog action to determine the next step that Amazon Lex V2 should use in
    /// the
    /// conversation with the user.
    session_state: SessionState,

    pub const json_field_names = .{
        .bot_alias_id = "botAliasId",
        .bot_id = "botId",
        .locale_id = "localeId",
        .messages = "messages",
        .request_attributes = "requestAttributes",
        .response_content_type = "responseContentType",
        .session_id = "sessionId",
        .session_state = "sessionState",
    };
};

pub const PutSessionOutput = struct {
    /// If the requested content type was audio, the audio version of the
    /// message to convey to the user.
    audio_stream: aws.http.StreamingBody = "",

    /// The type of response. Same as the type specified in the
    /// `responseContentType` field in the request.
    content_type: ?[]const u8 = null,

    /// A list of messages that were last sent to the user. The messages are
    /// ordered based on how you return the messages from you Lambda function
    /// or the order that the messages are defined in the bot.
    messages: ?[]const u8 = null,

    /// A base-64-encoded gzipped field that provides request-specific information
    /// passed between the client application and Amazon Lex V2. These are the same
    /// as the
    /// `requestAttribute` parameter in the call to the
    /// `PutSession` operation.
    request_attributes: ?[]const u8 = null,

    /// The identifier of the session that received the data.
    session_id: ?[]const u8 = null,

    /// A base-64-encoded gzipped field that represents the current state of
    /// the dialog between the user and the bot. Use this to determine the progress
    /// of the conversation and what the next action may be.
    session_state: ?[]const u8 = null,

    pub fn deinit(self: *PutSessionOutput) void {
        self.audio_stream.deinit();
    }

    pub const json_field_names = .{
        .audio_stream = "audioStream",
        .content_type = "contentType",
        .messages = "messages",
        .request_attributes = "requestAttributes",
        .session_id = "sessionId",
        .session_state = "sessionState",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: PutSessionInput, options: Options) !PutSessionOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "lexruntimev2");

    var stream_resp = try client.http_client.sendStreamingRequest(&request);

    arena.deinit();

    if (!stream_resp.isSuccess()) {
        defer stream_resp.deinit();
        const error_body = stream_resp.body.readAll(client.allocator, 10 * 1024 * 1024) catch return error.RequestFailed;
        defer client.allocator.free(error_body);
        if (options.diagnostic) |d| {
            d.* = parseErrorResponse(error_body, stream_resp.status, client.allocator) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(stream_resp.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeStreamingResponse(&stream_resp, allocator);
    return result;
}

fn serializeRequest(alloc: std.mem.Allocator, input: PutSessionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("lexruntimev2", "Lex Runtime V2", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var path_buf: std.ArrayList(u8) = .{};
    try path_buf.appendSlice(alloc, "/bots/");
    try path_buf.appendSlice(alloc, input.bot_id);
    try path_buf.appendSlice(alloc, "/botAliases/");
    try path_buf.appendSlice(alloc, input.bot_alias_id);
    try path_buf.appendSlice(alloc, "/botLocales/");
    try path_buf.appendSlice(alloc, input.locale_id);
    try path_buf.appendSlice(alloc, "/sessions/");
    try path_buf.appendSlice(alloc, input.session_id);
    const path = try path_buf.toOwnedSlice(alloc);

    var body_buf: std.ArrayList(u8) = .{};
    var has_prev = false;
    try body_buf.appendSlice(alloc, "{");

    if (input.messages) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"messages\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.request_attributes) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"requestAttributes\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(alloc, ",");
    try body_buf.appendSlice(alloc, "\"sessionState\":");
    try aws.json.writeValue(@TypeOf(input.session_state), input.session_state, alloc, &body_buf);
    has_prev = true;

    try body_buf.appendSlice(alloc, "}");
    const body = try body_buf.toOwnedSlice(alloc);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(alloc, "Content-Type", "application/json");
    if (input.response_content_type) |v| {
        try request.headers.put(alloc, "ResponseContentType", v);
    }

    return request;
}

fn deserializeStreamingResponse(stream_resp: *aws.http.StreamingResponse, alloc: std.mem.Allocator) !PutSessionOutput {
    var result: PutSessionOutput = .{};
    result.audio_stream = stream_resp.body;
    if (stream_resp.headers.get("content-type")) |value| {
        result.content_type = try alloc.dupe(u8, value);
    }
    if (stream_resp.headers.get("x-amz-lex-messages")) |value| {
        result.messages = try alloc.dupe(u8, value);
    }
    if (stream_resp.headers.get("x-amz-lex-request-attributes")) |value| {
        result.request_attributes = try alloc.dupe(u8, value);
    }
    if (stream_resp.headers.get("x-amz-lex-session-id")) |value| {
        result.session_id = try alloc.dupe(u8, value);
    }
    if (stream_resp.headers.get("x-amz-lex-session-state")) |value| {
        result.session_state = try alloc.dupe(u8, value);
    }
    stream_resp.deinitHeaders();

    return result;
}

fn parseErrorResponse(body: []const u8, status: u16, alloc: std.mem.Allocator) !ServiceError {
    const error_code = blk: {
        const type_str = aws.json.findJsonValue(body, "__type") orelse break :blk @as([]const u8, "Unknown");
        if (std.mem.lastIndexOfScalar(u8, type_str, '#')) |idx| {
            break :blk type_str[idx + 1 ..];
        }
        break :blk type_str;
    };
    const error_message = aws.json.findJsonValue(body, "message") orelse aws.json.findJsonValue(body, "Message") orelse "";
    var arena = std.heap.ArenaAllocator.init(alloc);
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
