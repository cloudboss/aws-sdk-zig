const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;

pub const RecognizeUtteranceInput = struct {
    /// The alias identifier in use for the bot that should receive the
    /// request.
    bot_alias_id: []const u8,

    /// The identifier of the bot that should receive the request.
    bot_id: []const u8,

    /// User input in PCM or Opus audio format or text format as described
    /// in the `requestContentType` parameter.
    input_stream: aws.http.StreamingBody = "",

    /// The locale where the session is in use.
    locale_id: []const u8,

    /// Request-specific information passed between the client application
    /// and Amazon Lex V2
    ///
    /// The namespace `x-amz-lex:` is reserved for special
    /// attributes. Don't create any request attributes for prefix
    /// `x-amz-lex:`.
    ///
    /// The `requestAttributes` field must be compressed using
    /// gzip and then base64 encoded before sending to Amazon Lex V2.
    request_attributes: ?[]const u8 = null,

    /// Indicates the format for audio input or that the content is text.
    /// The header must start with one of the following prefixes:
    ///
    /// * PCM format, audio data must be in little-endian byte
    /// order.
    ///
    /// * audio/l16; rate=16000; channels=1
    ///
    /// * audio/x-l16; sample-rate=16000; channel-count=1
    ///
    /// * audio/lpcm; sample-rate=8000; sample-size-bits=16;
    /// channel-count=1; is-big-endian=false
    ///
    /// * Opus format
    ///
    /// *
    ///   audio/x-cbr-opus-with-preamble;preamble-size=0;bit-rate=256000;frame-size-milliseconds=4
    ///
    /// * Text format
    ///
    /// * text/plain; charset=utf-8
    request_content_type: []const u8,

    /// The message that Amazon Lex V2 returns in the response can be either text or
    /// speech based on the `responseContentType` value.
    ///
    /// * If the value is `text/plain;charset=utf-8`, Amazon Lex V2
    /// returns text in the response.
    ///
    /// * If the value begins with `audio/`, Amazon Lex V2 returns
    /// speech in the response. Amazon Lex V2 uses Amazon Polly to generate the
    /// speech
    /// using the configuration that you specified in the
    /// `responseContentType` parameter. For example, if you
    /// specify `audio/mpeg` as the value, Amazon Lex V2 returns
    /// speech in the MPEG format.
    ///
    /// * If the value is `audio/pcm`, the speech returned is
    /// `audio/pcm` at 16 KHz in 16-bit, little-endian
    /// format.
    ///
    /// * The following are the accepted values:
    ///
    /// * audio/mpeg
    ///
    /// * audio/ogg
    ///
    /// * audio/pcm (16 KHz)
    ///
    /// * audio/* (defaults to mpeg)
    ///
    /// * text/plain; charset=utf-8
    response_content_type: ?[]const u8 = null,

    /// The identifier of the session in use.
    session_id: []const u8,

    /// Sets the state of the session with the user. You can use this to set
    /// the current intent, attributes, context, and dialog action. Use the
    /// dialog action to determine the next step that Amazon Lex V2 should use in
    /// the
    /// conversation with the user.
    ///
    /// The `sessionState` field must be compressed using gzip
    /// and then base64 encoded before sending to Amazon Lex V2.
    session_state: ?[]const u8 = null,

    pub const json_field_names = .{
        .bot_alias_id = "botAliasId",
        .bot_id = "botId",
        .input_stream = "inputStream",
        .locale_id = "localeId",
        .request_attributes = "requestAttributes",
        .request_content_type = "requestContentType",
        .response_content_type = "responseContentType",
        .session_id = "sessionId",
        .session_state = "sessionState",
    };
};

pub const RecognizeUtteranceOutput = struct {
    /// The prompt or statement to send to the user. This is based on the
    /// bot configuration and context. For example, if Amazon Lex V2 did not
    /// understand
    /// the user intent, it sends the `clarificationPrompt`
    /// configured for the bot. If the intent requires confirmation before
    /// taking the fulfillment action, it sends the
    /// `confirmationPrompt`. Another example: Suppose that the
    /// Lambda function successfully fulfilled the intent, and sent a message
    /// to convey to the user. Then Amazon Lex V2 sends that message in the
    /// response.
    audio_stream: aws.http.StreamingBody = "",

    /// Content type as specified in the `responseContentType` in
    /// the request.
    content_type: ?[]const u8 = null,

    /// Indicates whether the input mode to the operation was text, speech, or from
    /// a touch-tone keypad.
    input_mode: ?[]const u8 = null,

    /// The text used to process the request.
    ///
    /// If the input was an audio stream, the `inputTranscript`
    /// field contains the text extracted from the audio stream. This is the
    /// text that is actually processed to recognize intents and slot values.
    /// You can use this information to determine if Amazon Lex V2 is correctly
    /// processing the audio that you send.
    ///
    /// The `inputTranscript` field is compressed with gzip and
    /// then base64 encoded. Before you can use the contents of the field, you
    /// must decode and decompress the contents. See the example for a simple
    /// function to decode and decompress the contents.
    input_transcript: ?[]const u8 = null,

    /// A list of intents that Amazon Lex V2 determined might satisfy the user's
    /// utterance.
    ///
    /// Each interpretation includes the intent, a score that indicates how
    /// confident Amazon Lex V2 is that the interpretation is the correct one, and
    /// an
    /// optional sentiment response that indicates the sentiment expressed in
    /// the utterance.
    ///
    /// The `interpretations` field is compressed with gzip and
    /// then base64 encoded. Before you can use the contents of the field, you
    /// must decode and decompress the contents. See the example for a simple
    /// function to decode and decompress the contents.
    interpretations: ?[]const u8 = null,

    /// A list of messages that were last sent to the user. The messages are
    /// ordered based on the order that you returned the messages from your
    /// Lambda function or the order that the messages are defined in the
    /// bot.
    ///
    /// The `messages` field is compressed with gzip and then
    /// base64 encoded. Before you can use the contents of the field, you must
    /// decode and decompress the contents. See the example for a simple
    /// function to decode and decompress the contents.
    messages: ?[]const u8 = null,

    /// The bot member that recognized the utterance.
    recognized_bot_member: ?[]const u8 = null,

    /// The attributes sent in the request.
    ///
    /// The `requestAttributes` field is compressed with gzip and
    /// then base64 encoded. Before you can use the contents of the field, you
    /// must decode and decompress the contents.
    request_attributes: ?[]const u8 = null,

    /// The identifier of the session in use.
    session_id: ?[]const u8 = null,

    /// Represents the current state of the dialog between the user and the
    /// bot.
    ///
    /// Use this to determine the progress of the conversation and what the
    /// next action might be.
    ///
    /// The `sessionState` field is compressed with gzip and then
    /// base64 encoded. Before you can use the contents of the field, you must
    /// decode and decompress the contents. See the example for a simple
    /// function to decode and decompress the contents.
    session_state: ?[]const u8 = null,

    pub fn deinit(self: *RecognizeUtteranceOutput) void {
        self.audio_stream.deinit();
    }

    pub const json_field_names = .{
        .audio_stream = "audioStream",
        .content_type = "contentType",
        .input_mode = "inputMode",
        .input_transcript = "inputTranscript",
        .interpretations = "interpretations",
        .messages = "messages",
        .recognized_bot_member = "recognizedBotMember",
        .request_attributes = "requestAttributes",
        .session_id = "sessionId",
        .session_state = "sessionState",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: RecognizeUtteranceInput, options: Options) !RecognizeUtteranceOutput {
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

fn serializeRequest(alloc: std.mem.Allocator, input: RecognizeUtteranceInput, config: *aws.Config) !aws.http.Request {
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
    try path_buf.appendSlice(alloc, "/utterance");
    const path = try path_buf.toOwnedSlice(alloc);

    const body = input.input_stream orelse "";

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(alloc, "Content-Type", "application/json");
    if (input.request_attributes) |v| {
        try request.headers.put(alloc, "x-amz-lex-request-attributes", v);
    }
    try request.headers.put(alloc, "Content-Type", input.request_content_type);
    if (input.response_content_type) |v| {
        try request.headers.put(alloc, "Response-Content-Type", v);
    }
    if (input.session_state) |v| {
        try request.headers.put(alloc, "x-amz-lex-session-state", v);
    }

    return request;
}

fn deserializeStreamingResponse(stream_resp: *aws.http.StreamingResponse, alloc: std.mem.Allocator) !RecognizeUtteranceOutput {
    var result: RecognizeUtteranceOutput = .{};
    result.audio_stream = stream_resp.body;
    if (stream_resp.headers.get("content-type")) |value| {
        result.content_type = try alloc.dupe(u8, value);
    }
    if (stream_resp.headers.get("x-amz-lex-input-mode")) |value| {
        result.input_mode = try alloc.dupe(u8, value);
    }
    if (stream_resp.headers.get("x-amz-lex-input-transcript")) |value| {
        result.input_transcript = try alloc.dupe(u8, value);
    }
    if (stream_resp.headers.get("x-amz-lex-interpretations")) |value| {
        result.interpretations = try alloc.dupe(u8, value);
    }
    if (stream_resp.headers.get("x-amz-lex-messages")) |value| {
        result.messages = try alloc.dupe(u8, value);
    }
    if (stream_resp.headers.get("x-amz-lex-recognized-bot-member")) |value| {
        result.recognized_bot_member = try alloc.dupe(u8, value);
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
