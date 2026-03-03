const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const DialogState = @import("dialog_state.zig").DialogState;
const MessageFormatType = @import("message_format_type.zig").MessageFormatType;

pub const PostContentInput = struct {
    /// You pass this value as the `Accept` HTTP header.
    ///
    /// The message Amazon Lex returns in the response can be either text or
    /// speech based on the `Accept` HTTP header value in the request.
    ///
    /// * If the value is `text/plain; charset=utf-8`, Amazon Lex
    /// returns text in the response.
    ///
    /// * If the value begins with `audio/`, Amazon Lex returns
    /// speech in the response. Amazon Lex uses Amazon Polly to generate the speech
    /// (using the configuration you specified in the `Accept`
    /// header). For example, if you specify `audio/mpeg` as the
    /// value, Amazon Lex returns speech in the MPEG format.
    ///
    /// * If the value is `audio/pcm`, the speech returned is
    /// `audio/pcm` in 16-bit, little endian format.
    ///
    /// * The following are the accepted values:
    ///
    /// * audio/mpeg
    ///
    /// * audio/ogg
    ///
    /// * audio/pcm
    ///
    /// * text/plain; charset=utf-8
    ///
    /// * audio/* (defaults to mpeg)
    accept: ?[]const u8 = null,

    /// A list of contexts active for the request. A context can be activated
    /// when a previous intent is fulfilled, or by including the context in the
    /// request,
    ///
    /// If you don't specify a list of contexts, Amazon Lex will use the current
    /// list of contexts for the session. If you specify an empty list, all
    /// contexts for the session are cleared.
    active_contexts: ?[]const u8 = null,

    /// Alias of the Amazon Lex bot.
    bot_alias: []const u8,

    /// Name of the Amazon Lex bot.
    bot_name: []const u8,

    /// You pass this value as the `Content-Type` HTTP header.
    ///
    /// Indicates the audio format or text. The header value must start with
    /// one of the following prefixes:
    ///
    /// * PCM format, audio data must be in little-endian byte order.
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
    /// * audio/x-cbr-opus-with-preamble; preamble-size=0;
    /// bit-rate=256000; frame-size-milliseconds=4
    ///
    /// * Text format
    ///
    /// * text/plain; charset=utf-8
    content_type: []const u8,

    /// User input in PCM or Opus audio format or text format as described in
    /// the `Content-Type` HTTP header.
    ///
    /// You can stream audio data to Amazon Lex or you can create a local buffer
    /// that captures all of the audio data before sending. In general, you get
    /// better performance if you stream audio data rather than buffering the data
    /// locally.
    input_stream: []const u8,

    /// You pass this value as the `x-amz-lex-request-attributes`
    /// HTTP header.
    ///
    /// Request-specific information passed between Amazon Lex and a client
    /// application. The value must be a JSON serialized and base64 encoded map
    /// with string keys and values. The total size of the
    /// `requestAttributes` and `sessionAttributes`
    /// headers is limited to 12 KB.
    ///
    /// The namespace `x-amz-lex:` is reserved for special
    /// attributes. Don't create any request attributes with the prefix
    /// `x-amz-lex:`.
    ///
    /// For more information, see [Setting Request
    /// Attributes](https://docs.aws.amazon.com/lex/latest/dg/context-mgmt.html#context-mgmt-request-attribs).
    request_attributes: ?[]const u8 = null,

    /// You pass this value as the `x-amz-lex-session-attributes`
    /// HTTP header.
    ///
    /// Application-specific information passed between Amazon Lex and a client
    /// application. The value must be a JSON serialized and base64 encoded map
    /// with string keys and values. The total size of the
    /// `sessionAttributes` and `requestAttributes`
    /// headers is limited to 12 KB.
    ///
    /// For more information, see [Setting Session
    /// Attributes](https://docs.aws.amazon.com/lex/latest/dg/context-mgmt.html#context-mgmt-session-attribs).
    session_attributes: ?[]const u8 = null,

    /// The ID of the client application user. Amazon Lex uses this to identify a
    /// user's conversation with your bot. At runtime, each request must contain
    /// the `userID` field.
    ///
    /// To decide the user ID to use for your application, consider the
    /// following factors.
    ///
    /// * The `userID` field must not contain any personally
    /// identifiable information of the user, for example, name, personal
    /// identification numbers, or other end user personal information.
    ///
    /// * If you want a user to start a conversation on one device and
    /// continue on another device, use a user-specific identifier.
    ///
    /// * If you want the same user to be able to have two independent
    /// conversations on two different devices, choose a device-specific
    /// identifier.
    ///
    /// * A user can't have two independent conversations with two different
    /// versions of the same bot. For example, a user can't have a
    /// conversation with the PROD and BETA versions of the same bot. If you
    /// anticipate that a user will need to have conversation with two
    /// different versions, for example, while testing, include the bot alias
    /// in the user ID to separate the two conversations.
    user_id: []const u8,

    pub const json_field_names = .{
        .accept = "accept",
        .active_contexts = "activeContexts",
        .bot_alias = "botAlias",
        .bot_name = "botName",
        .content_type = "contentType",
        .input_stream = "inputStream",
        .request_attributes = "requestAttributes",
        .session_attributes = "sessionAttributes",
        .user_id = "userId",
    };
};

pub const PostContentOutput = struct {
    /// A list of active contexts for the session. A context can be set when
    /// an intent is fulfilled or by calling the `PostContent`,
    /// `PostText`, or `PutSession` operation.
    ///
    /// You can use a context to control the intents that can follow up an
    /// intent, or to modify the operation of your application.
    active_contexts: ?[]const u8 = null,

    /// One to four alternative intents that may be applicable to the user's
    /// intent.
    ///
    /// Each alternative includes a score that indicates how confident Amazon Lex
    /// is that the intent matches the user's intent. The intents are sorted by
    /// the confidence score.
    alternative_intents: ?[]const u8 = null,

    /// The prompt (or statement) to convey to the user. This is based on the
    /// bot configuration and context. For example, if Amazon Lex did not understand
    /// the user intent, it sends the `clarificationPrompt` configured
    /// for the bot. If the intent requires confirmation before taking the
    /// fulfillment action, it sends the `confirmationPrompt`. Another
    /// example: Suppose that the Lambda function successfully fulfilled the
    /// intent, and sent a message to convey to the user. Then Amazon Lex sends that
    /// message in the response.
    audio_stream: ?aws.http.StreamingBody = null,

    /// The version of the bot that responded to the conversation. You can use
    /// this information to help determine if one version of a bot is performing
    /// better than another version.
    bot_version: ?[]const u8 = null,

    /// Content type as specified in the `Accept` HTTP header in
    /// the request.
    content_type: ?[]const u8 = null,

    /// Identifies the current state of the user interaction. Amazon Lex returns
    /// one of the following values as `dialogState`. The client can
    /// optionally use this information to customize the user interface.
    ///
    /// * `ElicitIntent` - Amazon Lex wants to elicit the user's intent.
    /// Consider the following examples:
    ///
    /// For example, a user might utter an intent ("I want to order a
    /// pizza"). If Amazon Lex cannot infer the user intent from this utterance, it
    /// will return this dialog state.
    ///
    /// * `ConfirmIntent` - Amazon Lex is expecting a "yes" or "no"
    /// response.
    ///
    /// For example, Amazon Lex wants user confirmation before fulfilling an
    /// intent. Instead of a simple "yes" or "no" response, a user might
    /// respond with additional information. For example, "yes, but make it a
    /// thick crust pizza" or "no, I want to order a drink." Amazon Lex can process
    /// such additional information (in these examples, update the crust type
    /// slot or change the intent from OrderPizza to OrderDrink).
    ///
    /// * `ElicitSlot` - Amazon Lex is expecting the value of a slot for
    /// the current intent.
    ///
    /// For example, suppose that in the response Amazon Lex sends this
    /// message: "What size pizza would you like?". A user might reply with
    /// the slot value (e.g., "medium"). The user might also provide
    /// additional information in the response (e.g., "medium thick crust
    /// pizza"). Amazon Lex can process such additional information appropriately.
    ///
    /// * `Fulfilled` - Conveys that the Lambda function has
    /// successfully fulfilled the intent.
    ///
    /// * `ReadyForFulfillment` - Conveys that the client has to
    /// fulfill the request.
    ///
    /// * `Failed` - Conveys that the conversation with the user
    /// failed.
    ///
    /// This can happen for various reasons, including that the user does
    /// not provide an appropriate response to prompts from the service (you
    /// can configure how many times Amazon Lex can prompt a user for specific
    /// information), or if the Lambda function fails to fulfill the intent.
    dialog_state: ?DialogState = null,

    /// The text used to process the request.
    ///
    /// If the input was an audio stream, the
    /// `encodedInputTranscript` field contains the text extracted
    /// from the audio stream. This is the text that is actually processed to
    /// recognize intents and slot values. You can use this information to
    /// determine if Amazon Lex is correctly processing the audio that you send.
    ///
    /// The `encodedInputTranscript` field is base-64 encoded. You must
    /// decode the field before you can use the value.
    encoded_input_transcript: ?[]const u8 = null,

    /// The message to convey to the user. The message can come from the bot's
    /// configuration or from a Lambda function.
    ///
    /// If the intent is not configured with a Lambda function, or if the Lambda
    /// function returned `Delegate` as the
    /// `dialogAction.type` in its response, Amazon Lex decides on the
    /// next course of action and selects an appropriate message from the bot's
    /// configuration based on the current interaction context. For example, if
    /// Amazon Lex isn't able to understand user input, it uses a clarification
    /// prompt
    /// message.
    ///
    /// When you create an intent you can assign messages to groups. When
    /// messages are assigned to groups Amazon Lex returns one message from each
    /// group
    /// in the response. The message field is an escaped JSON string containing
    /// the messages. For more information about the structure of the JSON string
    /// returned, see msg-prompts-formats.
    ///
    /// If the Lambda function returns a message, Amazon Lex passes it to the client
    /// in its response.
    ///
    /// The `encodedMessage` field is base-64 encoded. You must
    /// decode the field before you can use the value.
    encoded_message: ?[]const u8 = null,

    /// The text used to process the request.
    ///
    /// You can use this field only in the de-DE, en-AU, en-GB, en-US, es-419,
    /// es-ES, es-US, fr-CA, fr-FR, and it-IT locales. In all other locales, the
    /// `inputTranscript` field is null. You should use the
    /// `encodedInputTranscript` field instead.
    ///
    /// If the input was an audio stream, the `inputTranscript`
    /// field contains the text extracted from the audio stream. This is the text
    /// that is actually processed to recognize intents and slot values. You can
    /// use this information to determine if Amazon Lex is correctly processing the
    /// audio that you send.
    input_transcript: ?[]const u8 = null,

    /// Current user intent that Amazon Lex is aware of.
    intent_name: ?[]const u8 = null,

    /// You can only use this field in the de-DE, en-AU, en-GB, en-US, es-419,
    /// es-ES, es-US, fr-CA, fr-FR, and it-IT locales. In all other locales, the
    /// `message` field is null. You should use the
    /// `encodedMessage` field instead.
    ///
    /// The message to convey to the user. The message can come from the bot's
    /// configuration or from a Lambda function.
    ///
    /// If the intent is not configured with a Lambda function, or if the Lambda
    /// function returned `Delegate` as the
    /// `dialogAction.type` in its response, Amazon Lex decides on the
    /// next course of action and selects an appropriate message from the bot's
    /// configuration based on the current interaction context. For example, if
    /// Amazon Lex isn't able to understand user input, it uses a clarification
    /// prompt
    /// message.
    ///
    /// When you create an intent you can assign messages to groups. When
    /// messages are assigned to groups Amazon Lex returns one message from each
    /// group
    /// in the response. The message field is an escaped JSON string containing
    /// the messages. For more information about the structure of the JSON string
    /// returned, see msg-prompts-formats.
    ///
    /// If the Lambda function returns a message, Amazon Lex passes it to the client
    /// in its response.
    message: ?[]const u8 = null,

    /// The format of the response message. One of the following
    /// values:
    ///
    /// * `PlainText` - The message contains plain UTF-8
    /// text.
    ///
    /// * `CustomPayload` - The message is a custom format for
    /// the client.
    ///
    /// * `SSML` - The message contains text formatted for voice
    /// output.
    ///
    /// * `Composite` - The message contains an escaped JSON
    /// object containing one or more messages from the groups that messages
    /// were assigned to when the intent was created.
    message_format: ?MessageFormatType = null,

    /// Provides a score that indicates how confident Amazon Lex is that the
    /// returned intent is the one that matches the user's intent. The score is
    /// between 0.0 and 1.0.
    ///
    /// The score is a relative score, not an absolute score. The score may
    /// change based on improvements to Amazon Lex.
    nlu_intent_confidence: ?[]const u8 = null,

    /// The sentiment expressed in an utterance.
    ///
    /// When the bot is configured to send utterances to Amazon Comprehend for
    /// sentiment analysis, this field contains the result of the analysis.
    sentiment_response: ?[]const u8 = null,

    /// Map of key/value pairs representing the session-specific context
    /// information.
    session_attributes: ?[]const u8 = null,

    /// The unique identifier for the session.
    session_id: ?[]const u8 = null,

    /// Map of zero or more intent slots (name/value pairs) Amazon Lex detected
    /// from the user input during the conversation. The field is base-64
    /// encoded.
    ///
    /// Amazon Lex creates a resolution list containing likely values for a slot.
    /// The value that it returns is determined by the
    /// `valueSelectionStrategy` selected when the slot type was
    /// created or updated. If `valueSelectionStrategy` is set to
    /// `ORIGINAL_VALUE`, the value provided by the user is returned,
    /// if the user value is similar to the slot values. If
    /// `valueSelectionStrategy` is set to
    /// `TOP_RESOLUTION` Amazon Lex returns the first value in the
    /// resolution list or, if there is no resolution list, null. If you don't
    /// specify a `valueSelectionStrategy`, the default is
    /// `ORIGINAL_VALUE`.
    slots: ?[]const u8 = null,

    /// If the `dialogState` value is `ElicitSlot`,
    /// returns the name of the slot for which Amazon Lex is eliciting a value.
    slot_to_elicit: ?[]const u8 = null,

    pub fn deinit(self: *PostContentOutput) void {
        if (self.audio_stream) |*b| b.deinit();
    }

    pub const json_field_names = .{
        .active_contexts = "activeContexts",
        .alternative_intents = "alternativeIntents",
        .audio_stream = "audioStream",
        .bot_version = "botVersion",
        .content_type = "contentType",
        .dialog_state = "dialogState",
        .encoded_input_transcript = "encodedInputTranscript",
        .encoded_message = "encodedMessage",
        .input_transcript = "inputTranscript",
        .intent_name = "intentName",
        .message = "message",
        .message_format = "messageFormat",
        .nlu_intent_confidence = "nluIntentConfidence",
        .sentiment_response = "sentimentResponse",
        .session_attributes = "sessionAttributes",
        .session_id = "sessionId",
        .slots = "slots",
        .slot_to_elicit = "slotToElicit",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: PostContentInput, options: CallOptions) !PostContentOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "lexruntimeservice");

    var stream_resp = try client.http_client.sendStreamingRequest(&request);

    arena.deinit();

    if (!stream_resp.isSuccess()) {
        defer stream_resp.deinit();
        const error_body = stream_resp.body.readAll(client.allocator, 10 * 1024 * 1024) catch return error.RequestFailed;
        defer client.allocator.free(error_body);
        if (options.diagnostic) |d| {
            d.* = parseErrorResponse(client.allocator, error_body, stream_resp.status) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(stream_resp.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeStreamingResponse(allocator, &stream_resp);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: PostContentInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("lexruntimeservice", "Lex Runtime Service", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var path_buf: std.ArrayList(u8) = .{};
    try path_buf.appendSlice(allocator, "/bot/");
    try path_buf.appendSlice(allocator, input.bot_name);
    try path_buf.appendSlice(allocator, "/alias/");
    try path_buf.appendSlice(allocator, input.bot_alias);
    try path_buf.appendSlice(allocator, "/user/");
    try path_buf.appendSlice(allocator, input.user_id);
    try path_buf.appendSlice(allocator, "/content");
    const path = try path_buf.toOwnedSlice(allocator);

    const body = input.input_stream;

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");
    if (input.accept) |v| {
        try request.headers.put(allocator, "Accept", v);
    }
    if (input.active_contexts) |v| {
        try request.headers.put(allocator, "x-amz-lex-active-contexts", v);
    }
    try request.headers.put(allocator, "Content-Type", input.content_type);
    if (input.request_attributes) |v| {
        try request.headers.put(allocator, "x-amz-lex-request-attributes", v);
    }
    if (input.session_attributes) |v| {
        try request.headers.put(allocator, "x-amz-lex-session-attributes", v);
    }

    return request;
}

fn deserializeStreamingResponse(allocator: std.mem.Allocator, stream_resp: *aws.http.StreamingResponse) !PostContentOutput {
    var result: PostContentOutput = .{};
    result.audio_stream = stream_resp.body;
    if (stream_resp.headers.get("x-amz-lex-active-contexts")) |value| {
        result.active_contexts = try allocator.dupe(u8, value);
    }
    if (stream_resp.headers.get("x-amz-lex-alternative-intents")) |value| {
        result.alternative_intents = try allocator.dupe(u8, value);
    }
    if (stream_resp.headers.get("x-amz-lex-bot-version")) |value| {
        result.bot_version = try allocator.dupe(u8, value);
    }
    if (stream_resp.headers.get("content-type")) |value| {
        result.content_type = try allocator.dupe(u8, value);
    }
    if (stream_resp.headers.get("x-amz-lex-dialog-state")) |value| {
        result.dialog_state = DialogState.fromWireName(value);
    }
    if (stream_resp.headers.get("x-amz-lex-encoded-input-transcript")) |value| {
        result.encoded_input_transcript = try allocator.dupe(u8, value);
    }
    if (stream_resp.headers.get("x-amz-lex-encoded-message")) |value| {
        result.encoded_message = try allocator.dupe(u8, value);
    }
    if (stream_resp.headers.get("x-amz-lex-input-transcript")) |value| {
        result.input_transcript = try allocator.dupe(u8, value);
    }
    if (stream_resp.headers.get("x-amz-lex-intent-name")) |value| {
        result.intent_name = try allocator.dupe(u8, value);
    }
    if (stream_resp.headers.get("x-amz-lex-message")) |value| {
        result.message = try allocator.dupe(u8, value);
    }
    if (stream_resp.headers.get("x-amz-lex-message-format")) |value| {
        result.message_format = MessageFormatType.fromWireName(value);
    }
    if (stream_resp.headers.get("x-amz-lex-nlu-intent-confidence")) |value| {
        result.nlu_intent_confidence = try allocator.dupe(u8, value);
    }
    if (stream_resp.headers.get("x-amz-lex-sentiment")) |value| {
        result.sentiment_response = try allocator.dupe(u8, value);
    }
    if (stream_resp.headers.get("x-amz-lex-session-attributes")) |value| {
        result.session_attributes = try allocator.dupe(u8, value);
    }
    if (stream_resp.headers.get("x-amz-lex-session-id")) |value| {
        result.session_id = try allocator.dupe(u8, value);
    }
    if (stream_resp.headers.get("x-amz-lex-slots")) |value| {
        result.slots = try allocator.dupe(u8, value);
    }
    if (stream_resp.headers.get("x-amz-lex-slot-to-elicit")) |value| {
        result.slot_to_elicit = try allocator.dupe(u8, value);
    }
    stream_resp.deinitHeaders();

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

    if (std.mem.eql(u8, error_code, "BadGatewayException")) {
        return .{ .arena = arena, .kind = .{ .bad_gateway_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "BadRequestException")) {
        return .{ .arena = arena, .kind = .{ .bad_request_exception = .{
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
    if (std.mem.eql(u8, error_code, "InternalFailureException")) {
        return .{ .arena = arena, .kind = .{ .internal_failure_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "LimitExceededException")) {
        return .{ .arena = arena, .kind = .{ .limit_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "LoopDetectedException")) {
        return .{ .arena = arena, .kind = .{ .loop_detected_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "NotAcceptableException")) {
        return .{ .arena = arena, .kind = .{ .not_acceptable_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "NotFoundException")) {
        return .{ .arena = arena, .kind = .{ .not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "RequestTimeoutException")) {
        return .{ .arena = arena, .kind = .{ .request_timeout_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "UnsupportedMediaTypeException")) {
        return .{ .arena = arena, .kind = .{ .unsupported_media_type_exception = .{
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
