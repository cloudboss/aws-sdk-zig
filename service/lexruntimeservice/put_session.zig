const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const ActiveContext = @import("active_context.zig").ActiveContext;
const DialogAction = @import("dialog_action.zig").DialogAction;
const IntentSummary = @import("intent_summary.zig").IntentSummary;
const DialogState = @import("dialog_state.zig").DialogState;
const MessageFormatType = @import("message_format_type.zig").MessageFormatType;

pub const PutSessionInput = struct {
    /// The message that Amazon Lex returns in the response can be either text or
    /// speech based depending on the value of this field.
    ///
    /// * If the value is `text/plain; charset=utf-8`, Amazon Lex
    /// returns text in the response.
    ///
    /// * If the value begins with `audio/`, Amazon Lex returns speech
    /// in the response. Amazon Lex uses Amazon Polly to generate the speech in the
    /// configuration that you specify. For example, if you specify
    /// `audio/mpeg` as the value, Amazon Lex returns speech in the
    /// MPEG format.
    ///
    /// * If the value is `audio/pcm`, the speech is returned as
    /// `audio/pcm` in 16-bit, little endian format.
    ///
    /// * The following are the accepted values:
    ///
    /// * `audio/mpeg`
    ///
    /// * `audio/ogg`
    ///
    /// * `audio/pcm`
    ///
    /// * `audio/*` (defaults to mpeg)
    ///
    /// * `text/plain; charset=utf-8`
    accept: ?[]const u8 = null,

    /// A list of contexts active for the request. A context can be activated
    /// when a previous intent is fulfilled, or by including the context in the
    /// request,
    ///
    /// If you don't specify a list of contexts, Amazon Lex will use the current
    /// list of contexts for the session. If you specify an empty list, all
    /// contexts for the session are cleared.
    active_contexts: ?[]const ActiveContext = null,

    /// The alias in use for the bot that contains the session data.
    bot_alias: []const u8,

    /// The name of the bot that contains the session data.
    bot_name: []const u8,

    /// Sets the next action that the bot should take to fulfill the
    /// conversation.
    dialog_action: ?DialogAction = null,

    /// A summary of the recent intents for the bot. You can use the intent
    /// summary view to set a checkpoint label on an intent and modify attributes
    /// of intents. You can also use it to remove or add intent summary objects to
    /// the list.
    ///
    /// An intent that you modify or add to the list must make sense for the
    /// bot. For example, the intent name must be valid for the bot. You must
    /// provide valid values for:
    ///
    /// * `intentName`
    ///
    /// * slot names
    ///
    /// * `slotToElict`
    ///
    /// If you send the `recentIntentSummaryView` parameter in a
    /// `PutSession` request, the contents of the new summary view
    /// replaces the old summary view. For example, if a `GetSession`
    /// request returns three intents in the summary view and you call
    /// `PutSession` with one intent in the summary view, the next
    /// call to `GetSession` will only return one intent.
    recent_intent_summary_view: ?[]const IntentSummary = null,

    /// Map of key/value pairs representing the session-specific context
    /// information. It contains application information passed between Amazon Lex
    /// and
    /// a client application.
    session_attributes: ?[]const aws.map.StringMapEntry = null,

    /// The ID of the client application user. Amazon Lex uses this to identify a
    /// user's conversation with your bot.
    user_id: []const u8,

    pub const json_field_names = .{
        .accept = "accept",
        .active_contexts = "activeContexts",
        .bot_alias = "botAlias",
        .bot_name = "botName",
        .dialog_action = "dialogAction",
        .recent_intent_summary_view = "recentIntentSummaryView",
        .session_attributes = "sessionAttributes",
        .user_id = "userId",
    };
};

pub const PutSessionOutput = struct {
    /// A list of active contexts for the session.
    active_contexts: ?[]const u8 = null,

    /// The audio version of the message to convey to the user.
    audio_stream: aws.http.StreamingBody = "",

    /// Content type as specified in the `Accept` HTTP header in
    /// the request.
    content_type: ?[]const u8 = null,

    /// * `ConfirmIntent` - Amazon Lex is expecting a "yes" or "no"
    /// response to confirm the intent before fulfilling an intent.
    ///
    /// * `ElicitIntent` - Amazon Lex wants to elicit the user's
    /// intent.
    ///
    /// * `ElicitSlot` - Amazon Lex is expecting the value of a slot
    /// for the current intent.
    ///
    /// * `Failed` - Conveys that the conversation with the user
    /// has failed. This can happen for various reasons, including the user
    /// does not provide an appropriate response to prompts from the service,
    /// or if the Lambda function fails to fulfill the intent.
    ///
    /// * `Fulfilled` - Conveys that the Lambda function has
    /// sucessfully fulfilled the intent.
    ///
    /// * `ReadyForFulfillment` - Conveys that the client has to
    /// fulfill the intent.
    dialog_state: ?DialogState = null,

    /// The next message that should be presented to the user.
    ///
    /// The `encodedMessage` field is base-64 encoded. You must
    /// decode the field before you can use the value.
    encoded_message: ?[]const u8 = null,

    /// The name of the current intent.
    intent_name: ?[]const u8 = null,

    /// The next message that should be presented to the user.
    ///
    /// You can only use this field in the de-DE, en-AU, en-GB, en-US, es-419,
    /// es-ES, es-US, fr-CA, fr-FR, and it-IT locales. In all other locales, the
    /// `message` field is null. You should use the
    /// `encodedMessage` field instead.
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

    /// Map of key/value pairs representing session-specific context
    /// information.
    session_attributes: ?[]const u8 = null,

    /// A unique identifier for the session.
    session_id: ?[]const u8 = null,

    /// Map of zero or more intent slots Amazon Lex detected from the user input
    /// during the conversation.
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
    /// specify a `valueSelectionStrategy` the default is
    /// `ORIGINAL_VALUE`.
    slots: ?[]const u8 = null,

    /// If the `dialogState` is `ElicitSlot`, returns
    /// the name of the slot for which Amazon Lex is eliciting a value.
    slot_to_elicit: ?[]const u8 = null,

    pub fn deinit(self: *PutSessionOutput) void {
        self.audio_stream.deinit();
    }

    pub const json_field_names = .{
        .active_contexts = "activeContexts",
        .audio_stream = "audioStream",
        .content_type = "contentType",
        .dialog_state = "dialogState",
        .encoded_message = "encodedMessage",
        .intent_name = "intentName",
        .message = "message",
        .message_format = "messageFormat",
        .session_attributes = "sessionAttributes",
        .session_id = "sessionId",
        .slots = "slots",
        .slot_to_elicit = "slotToElicit",
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
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "lexruntimeservice");

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
    const endpoint = try config.getEndpointForService("lexruntimeservice", "Lex Runtime Service", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var path_buf: std.ArrayList(u8) = .{};
    try path_buf.appendSlice(alloc, "/bot/");
    try path_buf.appendSlice(alloc, input.bot_name);
    try path_buf.appendSlice(alloc, "/alias/");
    try path_buf.appendSlice(alloc, input.bot_alias);
    try path_buf.appendSlice(alloc, "/user/");
    try path_buf.appendSlice(alloc, input.user_id);
    try path_buf.appendSlice(alloc, "/session");
    const path = try path_buf.toOwnedSlice(alloc);

    var body_buf: std.ArrayList(u8) = .{};
    var has_prev = false;
    try body_buf.appendSlice(alloc, "{");

    if (input.active_contexts) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"activeContexts\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.dialog_action) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"dialogAction\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.recent_intent_summary_view) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"recentIntentSummaryView\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.session_attributes) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"sessionAttributes\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(alloc, "}");
    const body = try body_buf.toOwnedSlice(alloc);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(alloc, "Content-Type", "application/json");
    if (input.accept) |v| {
        try request.headers.put(alloc, "Accept", v);
    }

    return request;
}

fn deserializeStreamingResponse(stream_resp: *aws.http.StreamingResponse, alloc: std.mem.Allocator) !PutSessionOutput {
    var result: PutSessionOutput = .{};
    result.audio_stream = stream_resp.body;
    if (stream_resp.headers.get("x-amz-lex-active-contexts")) |value| {
        result.active_contexts = try alloc.dupe(u8, value);
    }
    if (stream_resp.headers.get("content-type")) |value| {
        result.content_type = try alloc.dupe(u8, value);
    }
    if (stream_resp.headers.get("x-amz-lex-dialog-state")) |value| {
        result.dialog_state = std.meta.stringToEnum(DialogState, value);
    }
    if (stream_resp.headers.get("x-amz-lex-encoded-message")) |value| {
        result.encoded_message = try alloc.dupe(u8, value);
    }
    if (stream_resp.headers.get("x-amz-lex-intent-name")) |value| {
        result.intent_name = try alloc.dupe(u8, value);
    }
    if (stream_resp.headers.get("x-amz-lex-message")) |value| {
        result.message = try alloc.dupe(u8, value);
    }
    if (stream_resp.headers.get("x-amz-lex-message-format")) |value| {
        result.message_format = std.meta.stringToEnum(MessageFormatType, value);
    }
    if (stream_resp.headers.get("x-amz-lex-session-attributes")) |value| {
        result.session_attributes = try alloc.dupe(u8, value);
    }
    if (stream_resp.headers.get("x-amz-lex-session-id")) |value| {
        result.session_id = try alloc.dupe(u8, value);
    }
    if (stream_resp.headers.get("x-amz-lex-slots")) |value| {
        result.slots = try alloc.dupe(u8, value);
    }
    if (stream_resp.headers.get("x-amz-lex-slot-to-elicit")) |value| {
        result.slot_to_elicit = try alloc.dupe(u8, value);
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
