const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Statement = @import("statement.zig").Statement;
const Prompt = @import("prompt.zig").Prompt;
const CodeHook = @import("code_hook.zig").CodeHook;
const FollowUpPrompt = @import("follow_up_prompt.zig").FollowUpPrompt;
const FulfillmentActivity = @import("fulfillment_activity.zig").FulfillmentActivity;
const InputContext = @import("input_context.zig").InputContext;
const KendraConfiguration = @import("kendra_configuration.zig").KendraConfiguration;
const OutputContext = @import("output_context.zig").OutputContext;
const Slot = @import("slot.zig").Slot;

pub const GetIntentInput = struct {
    /// The name of the intent. The name is case sensitive.
    name: []const u8,

    /// The version of the intent.
    version: []const u8,

    pub const json_field_names = .{
        .name = "name",
        .version = "version",
    };
};

pub const GetIntentOutput = struct {
    /// Checksum of the intent.
    checksum: ?[]const u8 = null,

    /// After the Lambda function specified in the
    /// `fulfillmentActivity` element fulfills the intent, Amazon Lex
    /// conveys this statement to the user.
    conclusion_statement: ?Statement = null,

    /// If defined in the bot, Amazon Lex uses prompt to confirm the intent
    /// before fulfilling the user's request. For more information, see PutIntent.
    confirmation_prompt: ?Prompt = null,

    /// The date that the intent was created.
    created_date: ?i64 = null,

    /// A description of the intent.
    description: ?[]const u8 = null,

    /// If defined in the bot, Amazon Amazon Lex invokes this Lambda function
    /// for each user input. For more information, see PutIntent.
    dialog_code_hook: ?CodeHook = null,

    /// If defined in the bot, Amazon Lex uses this prompt to solicit additional
    /// user activity after the intent is fulfilled. For more information, see
    /// PutIntent.
    follow_up_prompt: ?FollowUpPrompt = null,

    /// Describes how the intent is fulfilled. For more information, see
    /// PutIntent.
    fulfillment_activity: ?FulfillmentActivity = null,

    /// An array of `InputContext` objects that lists the contexts
    /// that must be active for Amazon Lex to choose the intent in a conversation
    /// with
    /// the user.
    input_contexts: ?[]const InputContext = null,

    /// Configuration information, if any, to connect to an Amazon Kendra
    /// index with the `AMAZON.KendraSearchIntent` intent.
    kendra_configuration: ?KendraConfiguration = null,

    /// The date that the intent was updated. When you create a resource,
    /// the creation date and the last updated date are the same.
    last_updated_date: ?i64 = null,

    /// The name of the intent.
    name: ?[]const u8 = null,

    /// An array of `OutputContext` objects that lists the contexts
    /// that the intent activates when the intent is fulfilled.
    output_contexts: ?[]const OutputContext = null,

    /// A unique identifier for a built-in intent.
    parent_intent_signature: ?[]const u8 = null,

    /// If the user answers "no" to the question defined in
    /// `confirmationPrompt`, Amazon Lex responds with this statement to
    /// acknowledge that the intent was canceled.
    rejection_statement: ?Statement = null,

    /// An array of sample utterances configured for the intent.
    sample_utterances: ?[]const []const u8 = null,

    /// An array of intent slots configured for the intent.
    slots: ?[]const Slot = null,

    /// The version of the intent.
    version: ?[]const u8 = null,

    pub const json_field_names = .{
        .checksum = "checksum",
        .conclusion_statement = "conclusionStatement",
        .confirmation_prompt = "confirmationPrompt",
        .created_date = "createdDate",
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

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetIntentInput, options: CallOptions) !GetIntentOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "lex", client.config.http_client.clock_skew_offset);

    var response = try client.config.http_client.sendRequestWithOptions(&request, client.options);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = try parseErrorResponse(client.allocator, response.body, response.status);
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: GetIntentInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("models.lex", "Lex Model Building Service", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/intents/");
    try path_buf.appendSlice(allocator, input.name);
    try path_buf.appendSlice(allocator, "/versions/");
    try path_buf.appendSlice(allocator, input.version);
    const path = try path_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetIntentOutput {
    const result: GetIntentOutput = try aws.json.parseJsonObject(
        GetIntentOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
