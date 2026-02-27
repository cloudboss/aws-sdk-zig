const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const ActiveContext = @import("active_context.zig").ActiveContext;
const PredictedIntent = @import("predicted_intent.zig").PredictedIntent;
const DialogState = @import("dialog_state.zig").DialogState;
const MessageFormatType = @import("message_format_type.zig").MessageFormatType;
const IntentConfidence = @import("intent_confidence.zig").IntentConfidence;
const ResponseCard = @import("response_card.zig").ResponseCard;
const SentimentResponse = @import("sentiment_response.zig").SentimentResponse;

pub const PostTextInput = struct {
    /// A list of contexts active for the request. A context can be activated
    /// when a previous intent is fulfilled, or by including the context in the
    /// request,
    ///
    /// If you don't specify a list of contexts, Amazon Lex will use the current
    /// list of contexts for the session. If you specify an empty list, all
    /// contexts for the session are cleared.
    active_contexts: ?[]const ActiveContext = null,

    /// The alias of the Amazon Lex bot.
    bot_alias: []const u8,

    /// The name of the Amazon Lex bot.
    bot_name: []const u8,

    /// The text that the user entered (Amazon Lex interprets this text).
    input_text: []const u8,

    /// Request-specific information passed between Amazon Lex and a client
    /// application.
    ///
    /// The namespace `x-amz-lex:` is reserved for special
    /// attributes. Don't create any request attributes with the prefix
    /// `x-amz-lex:`.
    ///
    /// For more information, see [Setting Request
    /// Attributes](https://docs.aws.amazon.com/lex/latest/dg/context-mgmt.html#context-mgmt-request-attribs).
    request_attributes: ?[]const aws.map.StringMapEntry = null,

    /// Application-specific information passed between Amazon Lex and a client
    /// application.
    ///
    /// For more information, see [Setting Session
    /// Attributes](https://docs.aws.amazon.com/lex/latest/dg/context-mgmt.html#context-mgmt-session-attribs).
    session_attributes: ?[]const aws.map.StringMapEntry = null,

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
        .active_contexts = "activeContexts",
        .bot_alias = "botAlias",
        .bot_name = "botName",
        .input_text = "inputText",
        .request_attributes = "requestAttributes",
        .session_attributes = "sessionAttributes",
        .user_id = "userId",
    };
};

pub const PostTextOutput = struct {
    /// A list of active contexts for the session. A context can be set when
    /// an intent is fulfilled or by calling the `PostContent`,
    /// `PostText`, or `PutSession` operation.
    ///
    /// You can use a context to control the intents that can follow up an
    /// intent, or to modify the operation of your application.
    active_contexts: ?[]const ActiveContext = null,

    /// One to four alternative intents that may be applicable to the user's
    /// intent.
    ///
    /// Each alternative includes a score that indicates how confident Amazon Lex
    /// is that the intent matches the user's intent. The intents are sorted by
    /// the confidence score.
    alternative_intents: ?[]const PredictedIntent = null,

    /// The version of the bot that responded to the conversation. You can use
    /// this information to help determine if one version of a bot is performing
    /// better than another version.
    bot_version: ?[]const u8 = null,

    /// Identifies the current state of the user interaction. Amazon Lex returns
    /// one of the following values as `dialogState`. The client can
    /// optionally use this information to customize the user interface.
    ///
    /// * `ElicitIntent` - Amazon Lex wants to elicit user intent.
    ///
    /// For example, a user might utter an intent ("I want to order a
    /// pizza"). If Amazon Lex cannot infer the user intent from this utterance, it
    /// will return this dialogState.
    ///
    /// * `ConfirmIntent` - Amazon Lex is expecting a "yes" or "no"
    /// response.
    ///
    /// For example, Amazon Lex wants user confirmation before fulfilling an
    /// intent.
    ///
    /// Instead of a simple "yes" or "no," a user might respond with
    /// additional information. For example, "yes, but make it thick crust
    /// pizza" or "no, I want to order a drink". Amazon Lex can process such
    /// additional information (in these examples, update the crust type slot
    /// value, or change intent from OrderPizza to OrderDrink).
    ///
    /// * `ElicitSlot` - Amazon Lex is expecting a slot value for the
    /// current intent.
    ///
    /// For example, suppose that in the response Amazon Lex sends this
    /// message: "What size pizza would you like?". A user might reply with
    /// the slot value (e.g., "medium"). The user might also provide
    /// additional information in the response (e.g., "medium thick crust
    /// pizza"). Amazon Lex can process such additional information appropriately.
    ///
    /// * `Fulfilled` - Conveys that the Lambda function configured
    /// for the intent has successfully fulfilled the intent.
    ///
    /// * `ReadyForFulfillment` - Conveys that the client has to
    /// fulfill the intent.
    ///
    /// * `Failed` - Conveys that the conversation with the user
    /// failed.
    ///
    /// This can happen for various reasons including that the user did
    /// not provide an appropriate response to prompts from the service (you
    /// can configure how many times Amazon Lex can prompt a user for specific
    /// information), or the Lambda function failed to fulfill the intent.
    dialog_state: ?DialogState = null,

    /// The current user intent that Amazon Lex is aware of.
    intent_name: ?[]const u8 = null,

    /// The message to convey to the user. The message can come from the bot's
    /// configuration or from a Lambda function.
    ///
    /// If the intent is not configured with a Lambda function, or if the Lambda
    /// function returned `Delegate` as the
    /// `dialogAction.type` its response, Amazon Lex decides on the next
    /// course of action and selects an appropriate message from the bot's
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
    /// * `CustomPayload` - The message is a custom format
    /// defined by the Lambda function.
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
    /// between 0.0 and 1.0. For more information, see [Confidence
    /// Scores](https://docs.aws.amazon.com/lex/latest/dg/confidence-scores.html).
    ///
    /// The score is a relative score, not an absolute score. The score may
    /// change based on improvements to Amazon Lex.
    nlu_intent_confidence: ?IntentConfidence = null,

    /// Represents the options that the user has to respond to the current
    /// prompt. Response Card can come from the bot configuration (in the
    /// Amazon Lex console, choose the settings button next to a slot) or from a
    /// code hook (Lambda function).
    response_card: ?ResponseCard = null,

    /// The sentiment expressed in and utterance.
    ///
    /// When the bot is configured to send utterances to Amazon Comprehend for
    /// sentiment analysis, this field contains the result of the analysis.
    sentiment_response: ?SentimentResponse = null,

    /// A map of key-value pairs representing the session-specific context
    /// information.
    session_attributes: ?[]const aws.map.StringMapEntry = null,

    /// A unique identifier for the session.
    session_id: ?[]const u8 = null,

    /// The intent slots that Amazon Lex detected from the user input in the
    /// conversation.
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
    slots: ?[]const aws.map.StringMapEntry = null,

    /// If the `dialogState` value is `ElicitSlot`,
    /// returns the name of the slot for which Amazon Lex is eliciting a value.
    slot_to_elicit: ?[]const u8 = null,

    pub const json_field_names = .{
        .active_contexts = "activeContexts",
        .alternative_intents = "alternativeIntents",
        .bot_version = "botVersion",
        .dialog_state = "dialogState",
        .intent_name = "intentName",
        .message = "message",
        .message_format = "messageFormat",
        .nlu_intent_confidence = "nluIntentConfidence",
        .response_card = "responseCard",
        .sentiment_response = "sentimentResponse",
        .session_attributes = "sessionAttributes",
        .session_id = "sessionId",
        .slots = "slots",
        .slot_to_elicit = "slotToElicit",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: PostTextInput, options: Options) !PostTextOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "lexruntimeservice");

    var response = try client.http_client.sendRequest(&request);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = parseErrorResponse(response.body, response.status, client.allocator) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(response.body, response.status, response.headers, allocator);
    return result;
}

fn serializeRequest(alloc: std.mem.Allocator, input: PostTextInput, config: *aws.Config) !aws.http.Request {
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
    try path_buf.appendSlice(alloc, "/text");
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
    if (has_prev) try body_buf.appendSlice(alloc, ",");
    try body_buf.appendSlice(alloc, "\"inputText\":");
    try aws.json.writeValue(@TypeOf(input.input_text), input.input_text, alloc, &body_buf);
    has_prev = true;
    if (input.request_attributes) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"requestAttributes\":");
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

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !PostTextOutput {
    var result: PostTextOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(PostTextOutput, body, alloc);
    }
    _ = status;
    _ = headers;

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
