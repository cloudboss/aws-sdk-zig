const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const Statement = @import("statement.zig").Statement;
const Prompt = @import("prompt.zig").Prompt;
const CodeHook = @import("code_hook.zig").CodeHook;
const FollowUpPrompt = @import("follow_up_prompt.zig").FollowUpPrompt;
const FulfillmentActivity = @import("fulfillment_activity.zig").FulfillmentActivity;
const InputContext = @import("input_context.zig").InputContext;
const KendraConfiguration = @import("kendra_configuration.zig").KendraConfiguration;
const OutputContext = @import("output_context.zig").OutputContext;
const Slot = @import("slot.zig").Slot;

pub const PutIntentInput = struct {
    /// Identifies a specific revision of the `$LATEST`
    /// version.
    ///
    /// When you create a new intent, leave the `checksum` field
    /// blank. If you specify a checksum you get a
    /// `BadRequestException` exception.
    ///
    /// When you want to update a intent, set the `checksum`
    /// field to the checksum of the most recent revision of the
    /// `$LATEST` version. If you don't specify the `
    /// checksum` field, or if the checksum does not match the
    /// `$LATEST` version, you get a
    /// `PreconditionFailedException` exception.
    checksum: ?[]const u8 = null,

    /// The statement that you want Amazon Lex to convey to the user after the
    /// intent is successfully fulfilled by the Lambda function.
    ///
    /// This element is relevant only if you provide a Lambda function in
    /// the `fulfillmentActivity`. If you return the intent to the
    /// client application, you can't specify this element.
    ///
    /// The `followUpPrompt` and
    /// `conclusionStatement` are mutually exclusive. You can
    /// specify only one.
    conclusion_statement: ?Statement = null,

    /// Prompts the user to confirm the intent. This question should have a
    /// yes or no answer.
    ///
    /// Amazon Lex uses this prompt to ensure that the user acknowledges that
    /// the intent is ready for fulfillment. For example, with the
    /// `OrderPizza` intent, you might want to confirm that the order
    /// is correct before placing it. For other intents, such as intents that
    /// simply respond to user questions, you might not need to ask the user for
    /// confirmation before providing the information.
    ///
    /// You you must provide both the `rejectionStatement` and
    /// the `confirmationPrompt`, or neither.
    confirmation_prompt: ?Prompt = null,

    /// When set to `true` a new numbered version of the intent
    /// is created. This is the same as calling the
    /// `CreateIntentVersion` operation. If you do not specify
    /// `createVersion`, the default is `false`.
    create_version: ?bool = null,

    /// A description of the intent.
    description: ?[]const u8 = null,

    /// Specifies a Lambda function to invoke for each user input. You can
    /// invoke this Lambda function to personalize user interaction.
    ///
    /// For example, suppose your bot determines that the user is John.
    /// Your Lambda function might retrieve John's information from a backend
    /// database and prepopulate some of the values. For example, if you find that
    /// John is gluten intolerant, you might set the corresponding intent slot,
    /// `GlutenIntolerant`, to true. You might find John's phone
    /// number and set the corresponding session attribute.
    dialog_code_hook: ?CodeHook = null,

    /// Amazon Lex uses this prompt to solicit additional activity after
    /// fulfilling an intent. For example, after the `OrderPizza`
    /// intent is fulfilled, you might prompt the user to order a drink.
    ///
    /// The action that Amazon Lex takes depends on the user's response, as
    /// follows:
    ///
    /// * If the user says "Yes" it responds with the clarification
    /// prompt that is configured for the bot.
    ///
    /// * if the user says "Yes" and continues with an utterance that
    /// triggers an intent it starts a conversation for the intent.
    ///
    /// * If the user says "No" it responds with the rejection statement
    /// configured for the the follow-up prompt.
    ///
    /// * If it doesn't recognize the utterance it repeats the follow-up
    /// prompt again.
    ///
    /// The `followUpPrompt` field and the
    /// `conclusionStatement` field are mutually exclusive. You can
    /// specify only one.
    follow_up_prompt: ?FollowUpPrompt = null,

    /// Required. Describes how the intent is fulfilled. For example, after
    /// a user provides all of the information for a pizza order,
    /// `fulfillmentActivity` defines how the bot places an order
    /// with a local pizza store.
    ///
    /// You might configure Amazon Lex to return all of the intent information
    /// to the client application, or direct it to invoke a Lambda function that
    /// can process the intent (for example, place an order with a pizzeria).
    fulfillment_activity: ?FulfillmentActivity = null,

    /// An array of `InputContext` objects that lists the contexts
    /// that must be active for Amazon Lex to choose the intent in a conversation
    /// with
    /// the user.
    input_contexts: ?[]const InputContext = null,

    /// Configuration information required to use the
    /// `AMAZON.KendraSearchIntent` intent to connect to an Amazon
    /// Kendra index. For more information, see [
    /// AMAZON.KendraSearchIntent](http://docs.aws.amazon.com/lex/latest/dg/built-in-intent-kendra-search.html).
    kendra_configuration: ?KendraConfiguration = null,

    /// The name of the intent. The name is *not* case
    /// sensitive.
    ///
    /// The name can't match a built-in intent name, or a built-in intent
    /// name with "AMAZON." removed. For example, because there is a built-in
    /// intent called `AMAZON.HelpIntent`, you can't create a custom
    /// intent called `HelpIntent`.
    ///
    /// For a list of built-in intents, see [Standard Built-in
    /// Intents](https://developer.amazon.com/public/solutions/alexa/alexa-skills-kit/docs/built-in-intent-ref/standard-intents) in the *Alexa Skills
    /// Kit*.
    name: []const u8,

    /// An array of `OutputContext` objects that lists the contexts
    /// that the intent activates when the intent is fulfilled.
    output_contexts: ?[]const OutputContext = null,

    /// A unique identifier for the built-in intent to base this intent on.
    /// To find the signature for an intent, see [Standard Built-in
    /// Intents](https://developer.amazon.com/public/solutions/alexa/alexa-skills-kit/docs/built-in-intent-ref/standard-intents) in the *Alexa Skills
    /// Kit*.
    parent_intent_signature: ?[]const u8 = null,

    /// When the user answers "no" to the question defined in
    /// `confirmationPrompt`, Amazon Lex responds with this statement to
    /// acknowledge that the intent was canceled.
    ///
    /// You must provide both the `rejectionStatement` and the
    /// `confirmationPrompt`, or neither.
    rejection_statement: ?Statement = null,

    /// An array of utterances (strings) that a user might say to signal
    /// the intent. For example, "I want {PizzaSize} pizza", "Order {Quantity}
    /// {PizzaSize} pizzas".
    ///
    /// In each utterance, a slot name is enclosed in curly braces.
    sample_utterances: ?[]const []const u8 = null,

    /// An array of intent slots. At runtime, Amazon Lex elicits required slot
    /// values from the user using prompts defined in the slots. For more
    /// information, see how-it-works.
    slots: ?[]const Slot = null,

    pub const json_field_names = .{
        .checksum = "checksum",
        .conclusion_statement = "conclusionStatement",
        .confirmation_prompt = "confirmationPrompt",
        .create_version = "createVersion",
        .description = "description",
        .dialog_code_hook = "dialogCodeHook",
        .follow_up_prompt = "followUpPrompt",
        .fulfillment_activity = "fulfillmentActivity",
        .input_contexts = "inputContexts",
        .kendra_configuration = "kendraConfiguration",
        .name = "name",
        .output_contexts = "outputContexts",
        .parent_intent_signature = "parentIntentSignature",
        .rejection_statement = "rejectionStatement",
        .sample_utterances = "sampleUtterances",
        .slots = "slots",
    };
};

pub const PutIntentOutput = struct {
    /// Checksum of the `$LATEST`version of the intent created
    /// or updated.
    checksum: ?[]const u8 = null,

    /// After the Lambda function specified in
    /// the`fulfillmentActivity`intent fulfills the intent, Amazon Lex
    /// conveys this statement to the user.
    conclusion_statement: ?Statement = null,

    /// If defined in the intent, Amazon Lex prompts the user to confirm the
    /// intent before fulfilling it.
    confirmation_prompt: ?Prompt = null,

    /// The date that the intent was created.
    created_date: ?i64 = null,

    /// `True` if a new version of the intent was created. If
    /// the `createVersion` field was not specified in the request, the
    /// `createVersion` field is set to false in the
    /// response.
    create_version: ?bool = null,

    /// A description of the intent.
    description: ?[]const u8 = null,

    /// If defined in the intent, Amazon Lex invokes this Lambda function for
    /// each user input.
    dialog_code_hook: ?CodeHook = null,

    /// If defined in the intent, Amazon Lex uses this prompt to solicit
    /// additional user activity after the intent is fulfilled.
    follow_up_prompt: ?FollowUpPrompt = null,

    /// If defined in the intent, Amazon Lex invokes this Lambda function to
    /// fulfill the intent after the user provides all of the information required
    /// by the intent.
    fulfillment_activity: ?FulfillmentActivity = null,

    /// An array of `InputContext` objects that lists the contexts
    /// that must be active for Amazon Lex to choose the intent in a conversation
    /// with
    /// the user.
    input_contexts: ?[]const InputContext = null,

    /// Configuration information, if any, required to connect to an Amazon
    /// Kendra index and use the `AMAZON.KendraSearchIntent`
    /// intent.
    kendra_configuration: ?KendraConfiguration = null,

    /// The date that the intent was updated. When you create a resource,
    /// the creation date and last update dates are the same.
    last_updated_date: ?i64 = null,

    /// The name of the intent.
    name: ?[]const u8 = null,

    /// An array of `OutputContext` objects that lists the contexts
    /// that the intent activates when the intent is fulfilled.
    output_contexts: ?[]const OutputContext = null,

    /// A unique identifier for the built-in intent that this intent is
    /// based on.
    parent_intent_signature: ?[]const u8 = null,

    /// If the user answers "no" to the question defined in
    /// `confirmationPrompt` Amazon Lex responds with this statement to
    /// acknowledge that the intent was canceled.
    rejection_statement: ?Statement = null,

    /// An array of sample utterances that are configured for the intent.
    sample_utterances: ?[]const []const u8 = null,

    /// An array of intent slots that are configured for the
    /// intent.
    slots: ?[]const Slot = null,

    /// The version of the intent. For a new intent, the version is always
    /// `$LATEST`.
    version: ?[]const u8 = null,

    pub const json_field_names = .{
        .checksum = "checksum",
        .conclusion_statement = "conclusionStatement",
        .confirmation_prompt = "confirmationPrompt",
        .created_date = "createdDate",
        .create_version = "createVersion",
        .description = "description",
        .dialog_code_hook = "dialogCodeHook",
        .follow_up_prompt = "followUpPrompt",
        .fulfillment_activity = "fulfillmentActivity",
        .input_contexts = "inputContexts",
        .kendra_configuration = "kendraConfiguration",
        .last_updated_date = "lastUpdatedDate",
        .name = "name",
        .output_contexts = "outputContexts",
        .parent_intent_signature = "parentIntentSignature",
        .rejection_statement = "rejectionStatement",
        .sample_utterances = "sampleUtterances",
        .slots = "slots",
        .version = "version",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: PutIntentInput, options: CallOptions) !PutIntentOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
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

fn serializeRequest(allocator: std.mem.Allocator, input: PutIntentInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("models.lex", "Lex Model Building Service", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var path_buf: std.ArrayList(u8) = .{};
    try path_buf.appendSlice(allocator, "/intents/");
    try path_buf.appendSlice(allocator, input.name);
    try path_buf.appendSlice(allocator, "/versions/$LATEST");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .{};
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.checksum) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"checksum\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.conclusion_statement) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"conclusionStatement\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.confirmation_prompt) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"confirmationPrompt\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.create_version) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"createVersion\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
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
    if (input.follow_up_prompt) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"followUpPrompt\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.fulfillment_activity) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"fulfillmentActivity\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.input_contexts) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"inputContexts\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
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
    if (input.rejection_statement) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"rejectionStatement\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.sample_utterances) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"sampleUtterances\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.slots) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"slots\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !PutIntentOutput {
    var result: PutIntentOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(PutIntentOutput, body, allocator);
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
    if (std.mem.eql(u8, error_code, "NotFoundException")) {
        return .{ .arena = arena, .kind = .{ .not_found_exception = .{
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
    if (std.mem.eql(u8, error_code, "ResourceInUseException")) {
        return .{ .arena = arena, .kind = .{ .resource_in_use_exception = .{
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
