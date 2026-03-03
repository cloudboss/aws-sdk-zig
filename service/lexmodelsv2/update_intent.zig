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
const SlotPriority = @import("slot_priority.zig").SlotPriority;

pub const UpdateIntentInput = struct {
    /// The identifier of the bot that contains the intent.
    bot_id: []const u8,

    /// The version of the bot that contains the intent. Must be
    /// `DRAFT`.
    bot_version: []const u8,

    /// The new description of the intent.
    description: ?[]const u8 = null,

    /// The new Lambda function to use between each turn of the conversation
    /// with the bot.
    dialog_code_hook: ?DialogCodeHookSettings = null,

    /// The new Lambda function to call when all of the intents required
    /// slots are provided and the intent is ready for fulfillment.
    fulfillment_code_hook: ?FulfillmentCodeHookSettings = null,

    /// Configuration settings for a response sent to the user before Amazon Lex
    /// starts eliciting slots.
    initial_response_setting: ?InitialResponseSetting = null,

    /// A new list of contexts that must be active in order for Amazon Lex to
    /// consider the intent.
    input_contexts: ?[]const InputContext = null,

    /// The new response that Amazon Lex sends the user when the intent is
    /// closed.
    intent_closing_setting: ?IntentClosingSetting = null,

    /// New prompts that Amazon Lex sends to the user to confirm the completion
    /// of an intent.
    intent_confirmation_setting: ?IntentConfirmationSetting = null,

    /// The new display name for the intent.
    intent_display_name: ?[]const u8 = null,

    /// The unique identifier of the intent to update.
    intent_id: []const u8,

    /// The new name for the intent.
    intent_name: []const u8,

    /// New configuration settings for connecting to an Amazon Kendra index.
    kendra_configuration: ?KendraConfiguration = null,

    /// The identifier of the language and locale where this intent is used.
    /// The string must match one of the supported locales. For more
    /// information, see [Supported
    /// languages](https://docs.aws.amazon.com/lexv2/latest/dg/how-languages.html).
    locale_id: []const u8,

    /// A new list of contexts that Amazon Lex activates when the intent is
    /// fulfilled.
    output_contexts: ?[]const OutputContext = null,

    /// The signature of the new built-in intent to use as the parent of
    /// this intent.
    parent_intent_signature: ?[]const u8 = null,

    /// Qinconnect intent configuration details for the update intent request.
    q_in_connect_intent_configuration: ?QInConnectIntentConfiguration = null,

    /// Specifies the configuration of the built-in `Amazon.QnAIntent`. The
    /// `AMAZON.QnAIntent` intent is called when
    /// Amazon Lex can't determine another intent to invoke. If you specify this
    /// field, you can't specify the `kendraConfiguration` field.
    qn_a_intent_configuration: ?QnAIntentConfiguration = null,

    /// New utterances used to invoke the intent.
    sample_utterances: ?[]const SampleUtterance = null,

    /// A new list of slots and their priorities that are contained by the
    /// intent.
    slot_priorities: ?[]const SlotPriority = null,

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
        .intent_id = "intentId",
        .intent_name = "intentName",
        .kendra_configuration = "kendraConfiguration",
        .locale_id = "localeId",
        .output_contexts = "outputContexts",
        .parent_intent_signature = "parentIntentSignature",
        .q_in_connect_intent_configuration = "qInConnectIntentConfiguration",
        .qn_a_intent_configuration = "qnAIntentConfiguration",
        .sample_utterances = "sampleUtterances",
        .slot_priorities = "slotPriorities",
    };
};

pub const UpdateIntentOutput = struct {
    /// The identifier of the bot that contains the intent.
    bot_id: ?[]const u8 = null,

    /// The version of the bot that contains the intent. Will always be
    /// `DRAFT`.
    bot_version: ?[]const u8 = null,

    /// A timestamp of when the intent was created.
    creation_date_time: ?i64 = null,

    /// The updated description of the intent.
    description: ?[]const u8 = null,

    /// The updated Lambda function called during each turn of the
    /// conversation with the user.
    dialog_code_hook: ?DialogCodeHookSettings = null,

    /// The updated Lambda function called when the intent is ready for
    /// fulfillment.
    fulfillment_code_hook: ?FulfillmentCodeHookSettings = null,

    /// Configuration settings for a response sent to the user before Amazon Lex
    /// starts eliciting slots.
    initial_response_setting: ?InitialResponseSetting = null,

    /// The updated list of contexts that must be active for the intent to
    /// be considered by Amazon Lex.
    input_contexts: ?[]const InputContext = null,

    /// The updated response that Amazon Lex sends the user when the intent is
    /// closed.
    intent_closing_setting: ?IntentClosingSetting = null,

    /// The updated prompts that Amazon Lex sends to the user to confirm the
    /// completion of an intent.
    intent_confirmation_setting: ?IntentConfirmationSetting = null,

    /// The updated display name of the intent.
    intent_display_name: ?[]const u8 = null,

    /// The identifier of the intent that was updated.
    intent_id: ?[]const u8 = null,

    /// The updated name of the intent.
    intent_name: ?[]const u8 = null,

    /// The updated configuration for connecting to an Amazon Kendra index with the
    /// `AMAZON.KendraSearchIntent` intent.
    kendra_configuration: ?KendraConfiguration = null,

    /// A timestamp of the last time that the intent was modified.
    last_updated_date_time: ?i64 = null,

    /// The updated language and locale of the intent.
    locale_id: ?[]const u8 = null,

    /// The updated list of contexts that Amazon Lex activates when the intent is
    /// fulfilled.
    output_contexts: ?[]const OutputContext = null,

    /// The updated built-in intent that is the parent of this
    /// intent.
    parent_intent_signature: ?[]const u8 = null,

    /// Qinconnect intent configuration details for the update intent response.
    q_in_connect_intent_configuration: ?QInConnectIntentConfiguration = null,

    /// Details about the configuration of the built-in `Amazon.QnAIntent`.
    qn_a_intent_configuration: ?QnAIntentConfiguration = null,

    /// The updated list of sample utterances for the intent.
    sample_utterances: ?[]const SampleUtterance = null,

    /// The updated list of slots and their priorities that are elicited
    /// from the user for the intent.
    slot_priorities: ?[]const SlotPriority = null,

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
        .last_updated_date_time = "lastUpdatedDateTime",
        .locale_id = "localeId",
        .output_contexts = "outputContexts",
        .parent_intent_signature = "parentIntentSignature",
        .q_in_connect_intent_configuration = "qInConnectIntentConfiguration",
        .qn_a_intent_configuration = "qnAIntentConfiguration",
        .sample_utterances = "sampleUtterances",
        .slot_priorities = "slotPriorities",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateIntentInput, options: Options) !UpdateIntentOutput {
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
            d.* = parseErrorResponse(client.allocator, response.body, response.status) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateIntentInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("lexmodelsv2", "Lex Models V2", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var path_buf: std.ArrayList(u8) = .{};
    try path_buf.appendSlice(allocator, "/bots/");
    try path_buf.appendSlice(allocator, input.bot_id);
    try path_buf.appendSlice(allocator, "/botversions/");
    try path_buf.appendSlice(allocator, input.bot_version);
    try path_buf.appendSlice(allocator, "/botlocales/");
    try path_buf.appendSlice(allocator, input.locale_id);
    try path_buf.appendSlice(allocator, "/intents/");
    try path_buf.appendSlice(allocator, input.intent_id);
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .{};
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.description) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"description\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.dialog_code_hook) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"dialogCodeHook\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.fulfillment_code_hook) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"fulfillmentCodeHook\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.initial_response_setting) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"initialResponseSetting\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.input_contexts) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"inputContexts\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.intent_closing_setting) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"intentClosingSetting\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.intent_confirmation_setting) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"intentConfirmationSetting\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.intent_display_name) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"intentDisplayName\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"intentName\":");
    try aws.json.writeValue(@TypeOf(input.intent_name), input.intent_name, allocator, &body_buf);
    has_prev = true;
    if (input.kendra_configuration) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"kendraConfiguration\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.output_contexts) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"outputContexts\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.parent_intent_signature) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"parentIntentSignature\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.q_in_connect_intent_configuration) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"qInConnectIntentConfiguration\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.qn_a_intent_configuration) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"qnAIntentConfiguration\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.sample_utterances) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"sampleUtterances\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.slot_priorities) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"slotPriorities\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(host);
    request.method = .PUT;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateIntentOutput {
    var result: UpdateIntentOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(UpdateIntentOutput, body, allocator);
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
