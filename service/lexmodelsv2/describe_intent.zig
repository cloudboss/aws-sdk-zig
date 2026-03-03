const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
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

pub const DescribeIntentInput = struct {
    /// The identifier of the bot associated with the intent.
    bot_id: []const u8,

    /// The version of the bot associated with the intent.
    bot_version: []const u8,

    /// The identifier of the intent to describe.
    intent_id: []const u8,

    /// The identifier of the language and locale of the intent to describe.
    /// The string must match one of the supported locales. For more
    /// information, see [Supported
    /// languages](https://docs.aws.amazon.com/lexv2/latest/dg/how-languages.html).
    locale_id: []const u8,

    pub const json_field_names = .{
        .bot_id = "botId",
        .bot_version = "botVersion",
        .intent_id = "intentId",
        .locale_id = "localeId",
    };
};

pub const DescribeIntentOutput = struct {
    /// The identifier of the bot associated with the intent.
    bot_id: ?[]const u8 = null,

    /// The version of the bot associated with the intent.
    bot_version: ?[]const u8 = null,

    /// A timestamp of the date and time that the intent was created.
    creation_date_time: ?i64 = null,

    /// The description of the intent.
    description: ?[]const u8 = null,

    /// The Lambda function called during each turn of a conversation with
    /// the intent.
    dialog_code_hook: ?DialogCodeHookSettings = null,

    /// The Lambda function called when the intent is complete and ready for
    /// fulfillment.
    fulfillment_code_hook: ?FulfillmentCodeHookSettings = null,

    /// Configuration setting for a response sent to the user before Amazon Lex
    /// starts eliciting slots.
    initial_response_setting: ?InitialResponseSetting = null,

    /// A list of contexts that must be active for the intent to be
    /// considered for sending to the user.
    input_contexts: ?[]const InputContext = null,

    /// The response that Amazon Lex sends to when the intent is closed.
    intent_closing_setting: ?IntentClosingSetting = null,

    /// Prompts that Amazon Lex sends to the user to confirm completion of an
    /// intent.
    intent_confirmation_setting: ?IntentConfirmationSetting = null,

    /// The display name specified for the intent.
    intent_display_name: ?[]const u8 = null,

    /// The unique identifier assigned to the intent when it was
    /// created.
    intent_id: ?[]const u8 = null,

    /// The name specified for the intent.
    intent_name: ?[]const u8 = null,

    /// Configuration information required to use the
    /// `AMAZON.KendraSearchIntent` intent.
    kendra_configuration: ?KendraConfiguration = null,

    /// A timestamp of the date and time that the intent was last
    /// updated.
    last_updated_date_time: ?i64 = null,

    /// The language and locale specified for the intent.
    locale_id: ?[]const u8 = null,

    /// A list of contexts that are activated when the intent is
    /// fulfilled.
    output_contexts: ?[]const OutputContext = null,

    /// The identifier of the built-in intent that this intent is derived
    /// from, if any.
    parent_intent_signature: ?[]const u8 = null,

    /// Qinconnect intent configuration details for the describe intent response.
    q_in_connect_intent_configuration: ?QInConnectIntentConfiguration = null,

    /// Details about the configuration of the built-in `Amazon.QnAIntent`.
    qn_a_intent_configuration: ?QnAIntentConfiguration = null,

    /// User utterances that trigger this intent.
    sample_utterances: ?[]const SampleUtterance = null,

    /// The list that determines the priority that slots should be elicited
    /// from the user.
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

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeIntentInput, options: CallOptions) !DescribeIntentOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeIntentInput, config: *aws.Config) !aws.http.Request {
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

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(host);
    request.method = .GET;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeIntentOutput {
    var result: DescribeIntentOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(DescribeIntentOutput, body, allocator);
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
