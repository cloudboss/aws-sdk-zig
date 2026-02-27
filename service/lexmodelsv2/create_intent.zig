const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const DialogCodeHookSettings = @import("dialog_code_hook_settings.zig").DialogCodeHookSettings;
const FulfillmentCodeHookSettings = @import("fulfillment_code_hook_settings.zig").FulfillmentCodeHookSettings;
const InitialResponseSetting = @import("initial_response_setting.zig").InitialResponseSetting;
const InputContext = @import("input_context.zig").InputContext;
const IntentClosingSetting = @import("intent_closing_setting.zig").IntentClosingSetting;
const IntentConfirmationSetting = @import("intent_confirmation_setting.zig").IntentConfirmationSetting;
const KendraConfiguration = @import("kendra_configuration.zig").KendraConfiguration;
const OutputContext = @import("output_context.zig").OutputContext;
const QInConnectIntentConfiguration = @import("q_in_connect_intent_configuration.zig").QInConnectIntentConfiguration;
const QnAIntentConfiguration = @import("qn_a_intent_configuration.zig").QnAIntentConfiguration;
const SampleUtterance = @import("sample_utterance.zig").SampleUtterance;

pub const CreateIntentInput = struct {
    /// The identifier of the bot associated with this intent.
    bot_id: []const u8,

    /// The version of the bot associated with this
    /// intent.
    bot_version: []const u8,

    /// A description of the intent. Use the description to help identify
    /// the intent in lists.
    description: ?[]const u8 = null,

    /// Specifies that Amazon Lex invokes the alias Lambda function for each user
    /// input. You can invoke this Lambda function to personalize user
    /// interaction.
    ///
    /// For example, suppose that your bot determines that the user's name
    /// is John. You Lambda function might retrieve John's information from a
    /// backend database and prepopulate some of the values. For example, if
    /// you find that John is gluten intolerant, you might set the
    /// corresponding intent slot, `glutenIntolerant` to
    /// `true`. You might find John's phone number and set the
    /// corresponding session attribute.
    dialog_code_hook: ?DialogCodeHookSettings = null,

    /// Specifies that Amazon Lex invokes the alias Lambda function when the
    /// intent is ready for fulfillment. You can invoke this function to
    /// complete the bot's transaction with the user.
    ///
    /// For example, in a pizza ordering bot, the Lambda function can look up
    /// the closest pizza restaurant to the customer's location and then place
    /// an order on the customer's behalf.
    fulfillment_code_hook: ?FulfillmentCodeHookSettings = null,

    /// Configuration settings for the response that is sent to the user at
    /// the beginning of a conversation, before eliciting slot values.
    initial_response_setting: ?InitialResponseSetting = null,

    /// A list of contexts that must be active for this intent to be
    /// considered by Amazon Lex.
    ///
    /// When an intent has an input context list, Amazon Lex only considers using
    /// the intent in an interaction with the user when the specified contexts
    /// are included in the active context list for the session. If the
    /// contexts are not active, then Amazon Lex will not use the intent.
    ///
    /// A context can be automatically activated using the
    /// `outputContexts` property or it can be set at
    /// runtime.
    ///
    /// For example, if there are two intents with different input contexts
    /// that respond to the same utterances, only the intent with the active
    /// context will respond.
    ///
    /// An intent may have up to 5 input contexts. If an intent has multiple
    /// input contexts, all of the contexts must be active to consider the
    /// intent.
    input_contexts: ?[]const InputContext = null,

    /// Sets the response that Amazon Lex sends to the user when the intent is
    /// closed.
    intent_closing_setting: ?IntentClosingSetting = null,

    /// Provides prompts that Amazon Lex sends to the user to confirm the
    /// completion of an intent. If the user answers "no," the settings contain
    /// a statement that is sent to the user to end the intent.
    intent_confirmation_setting: ?IntentConfirmationSetting = null,

    /// A display name for the intent. If configured, This name will be shown to
    /// users during Intent Disambiguation instead of the intent name. Display names
    /// should be user-friendly, descriptive and match the intent's purpose to
    /// improve user experience
    /// during disambiguation.
    intent_display_name: ?[]const u8 = null,

    /// The name of the intent. Intent names must be unique in the locale
    /// that contains the intent and cannot match the name of any built-in
    /// intent.
    intent_name: []const u8,

    /// Configuration information required to use the
    /// `AMAZON.KendraSearchIntent` intent to connect to an Amazon Kendra
    /// index. The `AMAZON.KendraSearchIntent` intent is called when
    /// Amazon Lex can't determine another intent to invoke.
    kendra_configuration: ?KendraConfiguration = null,

    /// The identifier of the language and locale where this intent is used.
    /// All of the bots, slot types, and slots used by the intent must have the
    /// same locale. For more information, see [Supported
    /// languages](https://docs.aws.amazon.com/lexv2/latest/dg/how-languages.html).
    locale_id: []const u8,

    /// A lists of contexts that the intent activates when it is
    /// fulfilled.
    ///
    /// You can use an output context to indicate the intents that Amazon Lex
    /// should consider for the next turn of the conversation with a customer.
    ///
    /// When you use the `outputContextsList` property, all of
    /// the contexts specified in the list are activated when the intent is
    /// fulfilled. You can set up to 10 output contexts. You can also set the
    /// number of conversation turns that the context should be active, or the
    /// length of time that the context should be active.
    output_contexts: ?[]const OutputContext = null,

    /// A unique identifier for the built-in intent to base this intent
    /// on.
    parent_intent_signature: ?[]const u8 = null,

    /// Qinconnect intent configuration details for the create intent request.
    q_in_connect_intent_configuration: ?QInConnectIntentConfiguration = null,

    /// Specifies the configuration of the built-in `Amazon.QnAIntent`. The
    /// `AMAZON.QnAIntent` intent is called when
    /// Amazon Lex can't determine another intent to invoke. If you specify this
    /// field, you can't specify the `kendraConfiguration` field.
    qn_a_intent_configuration: ?QnAIntentConfiguration = null,

    /// An array of strings that a user might say to signal the intent. For
    /// example, "I want a pizza", or "I want a {PizzaSize} pizza".
    ///
    /// In an utterance, slot names are enclosed in curly braces ("{", "}")
    /// to indicate where they should be displayed in the utterance shown to
    /// the user..
    sample_utterances: ?[]const SampleUtterance = null,

    pub const json_field_names = .{
        .bot_id = "botId",
        .bot_version = "botVersion",
        .description = "description",
        .dialog_code_hook = "dialogCodeHook",
        .fulfillment_code_hook = "fulfillmentCodeHook",
        .initial_response_setting = "initialResponseSetting",
        .input_contexts = "inputContexts",
        .intent_closing_setting = "intentClosingSetting",
        .intent_confirmation_setting = "intentConfirmationSetting",
        .intent_display_name = "intentDisplayName",
        .intent_name = "intentName",
        .kendra_configuration = "kendraConfiguration",
        .locale_id = "localeId",
        .output_contexts = "outputContexts",
        .parent_intent_signature = "parentIntentSignature",
        .q_in_connect_intent_configuration = "qInConnectIntentConfiguration",
        .qn_a_intent_configuration = "qnAIntentConfiguration",
        .sample_utterances = "sampleUtterances",
    };
};

pub const CreateIntentOutput = struct {
    /// The identifier of the bot associated with the intent.
    bot_id: ?[]const u8 = null,

    /// The version of the bot associated with the
    /// intent.
    bot_version: ?[]const u8 = null,

    /// A timestamp of the date and time that the intent was created.
    creation_date_time: ?i64 = null,

    /// The description specified for the intent.
    description: ?[]const u8 = null,

    /// The dialog Lambda function specified for the intent.
    dialog_code_hook: ?DialogCodeHookSettings = null,

    /// The fulfillment Lambda function specified for the intent.
    fulfillment_code_hook: ?FulfillmentCodeHookSettings = null,

    /// Configuration settings for the response that is sent to the user at
    /// the beginning of a conversation, before eliciting slot values.
    initial_response_setting: ?InitialResponseSetting = null,

    /// The list of input contexts specified for the intent.
    input_contexts: ?[]const InputContext = null,

    /// The closing setting specified for the intent.
    intent_closing_setting: ?IntentClosingSetting = null,

    /// The confirmation setting specified for the intent.
    intent_confirmation_setting: ?IntentConfirmationSetting = null,

    /// The display name specified for the intent.
    intent_display_name: ?[]const u8 = null,

    /// A unique identifier for the intent.
    intent_id: ?[]const u8 = null,

    /// The name specified for the intent.
    intent_name: ?[]const u8 = null,

    /// Configuration for searching a Amazon Kendra index specified for the
    /// intent.
    kendra_configuration: ?KendraConfiguration = null,

    /// The locale that the intent is specified to use.
    locale_id: ?[]const u8 = null,

    /// The list of output contexts specified for the intent.
    output_contexts: ?[]const OutputContext = null,

    /// The signature of the parent intent specified for the intent.
    parent_intent_signature: ?[]const u8 = null,

    /// Qinconnect intent configuration details for the create intent response.
    q_in_connect_intent_configuration: ?QInConnectIntentConfiguration = null,

    /// Details about the the configuration of the built-in `Amazon.QnAIntent`.
    qn_a_intent_configuration: ?QnAIntentConfiguration = null,

    /// The sample utterances specified for the intent.
    sample_utterances: ?[]const SampleUtterance = null,

    pub const json_field_names = .{
        .bot_id = "botId",
        .bot_version = "botVersion",
        .creation_date_time = "creationDateTime",
        .description = "description",
        .dialog_code_hook = "dialogCodeHook",
        .fulfillment_code_hook = "fulfillmentCodeHook",
        .initial_response_setting = "initialResponseSetting",
        .input_contexts = "inputContexts",
        .intent_closing_setting = "intentClosingSetting",
        .intent_confirmation_setting = "intentConfirmationSetting",
        .intent_display_name = "intentDisplayName",
        .intent_id = "intentId",
        .intent_name = "intentName",
        .kendra_configuration = "kendraConfiguration",
        .locale_id = "localeId",
        .output_contexts = "outputContexts",
        .parent_intent_signature = "parentIntentSignature",
        .q_in_connect_intent_configuration = "qInConnectIntentConfiguration",
        .qn_a_intent_configuration = "qnAIntentConfiguration",
        .sample_utterances = "sampleUtterances",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateIntentInput, options: Options) !CreateIntentOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "lexmodelsv2");

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

fn serializeRequest(alloc: std.mem.Allocator, input: CreateIntentInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("lexmodelsv2", "Lex Models V2", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var path_buf: std.ArrayList(u8) = .{};
    try path_buf.appendSlice(alloc, "/bots/");
    try path_buf.appendSlice(alloc, input.bot_id);
    try path_buf.appendSlice(alloc, "/botversions/");
    try path_buf.appendSlice(alloc, input.bot_version);
    try path_buf.appendSlice(alloc, "/botlocales/");
    try path_buf.appendSlice(alloc, input.locale_id);
    try path_buf.appendSlice(alloc, "/intents");
    const path = try path_buf.toOwnedSlice(alloc);

    var body_buf: std.ArrayList(u8) = .{};
    var has_prev = false;
    try body_buf.appendSlice(alloc, "{");

    if (input.description) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"description\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.dialog_code_hook) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"dialogCodeHook\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.fulfillment_code_hook) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"fulfillmentCodeHook\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.initial_response_setting) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"initialResponseSetting\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.input_contexts) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"inputContexts\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.intent_closing_setting) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"intentClosingSetting\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.intent_confirmation_setting) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"intentConfirmationSetting\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.intent_display_name) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"intentDisplayName\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(alloc, ",");
    try body_buf.appendSlice(alloc, "\"intentName\":");
    try aws.json.writeValue(@TypeOf(input.intent_name), input.intent_name, alloc, &body_buf);
    has_prev = true;
    if (input.kendra_configuration) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"kendraConfiguration\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.output_contexts) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"outputContexts\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.parent_intent_signature) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"parentIntentSignature\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.q_in_connect_intent_configuration) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"qInConnectIntentConfiguration\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.qn_a_intent_configuration) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"qnAIntentConfiguration\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.sample_utterances) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"sampleUtterances\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(alloc, "}");
    const body = try body_buf.toOwnedSlice(alloc);

    var request = aws.http.Request.init(host);
    request.method = .PUT;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(alloc, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !CreateIntentOutput {
    var result: CreateIntentOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CreateIntentOutput, body, alloc);
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

    if (std.mem.eql(u8, error_code, "ConflictException")) {
        return .{ .arena = arena, .kind = .{ .conflict_exception = .{
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
    if (std.mem.eql(u8, error_code, "PreconditionFailedException")) {
        return .{ .arena = arena, .kind = .{ .precondition_failed_exception = .{
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
    if (std.mem.eql(u8, error_code, "ServiceQuotaExceededException")) {
        return .{ .arena = arena, .kind = .{ .service_quota_exceeded_exception = .{
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
