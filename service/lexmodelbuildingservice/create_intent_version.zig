const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
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

pub const CreateIntentVersionInput = struct {
    /// Checksum of the `$LATEST` version of the intent that
    /// should be used to create the new version. If you specify a checksum and
    /// the `$LATEST` version of the intent has a different checksum,
    /// Amazon Lex returns a `PreconditionFailedException` exception and
    /// doesn't publish a new version. If you don't specify a checksum, Amazon Lex
    /// publishes the `$LATEST` version.
    checksum: ?[]const u8 = null,

    /// The name of the intent that you want to create a new version of.
    /// The name is case sensitive.
    name: []const u8,

    pub const json_field_names = .{
        .checksum = "checksum",
        .name = "name",
    };
};

pub const CreateIntentVersionOutput = struct {
    /// Checksum of the intent version created.
    checksum: ?[]const u8 = null,

    /// After the Lambda function specified in the
    /// `fulfillmentActivity` field fulfills the intent, Amazon Lex
    /// conveys this statement to the user.
    conclusion_statement: ?Statement = null,

    /// If defined, the prompt that Amazon Lex uses to confirm the user's
    /// intent before fulfilling it.
    confirmation_prompt: ?Prompt = null,

    /// The date that the intent was created.
    created_date: ?i64 = null,

    /// A description of the intent.
    description: ?[]const u8 = null,

    /// If defined, Amazon Lex invokes this Lambda function for each user
    /// input.
    dialog_code_hook: ?CodeHook = null,

    /// If defined, Amazon Lex uses this prompt to solicit additional user
    /// activity after the intent is fulfilled.
    follow_up_prompt: ?FollowUpPrompt = null,

    /// Describes how the intent is fulfilled.
    fulfillment_activity: ?FulfillmentActivity = null,

    /// An array of `InputContext` objects that lists the contexts
    /// that must be active for Amazon Lex to choose the intent in a conversation
    /// with
    /// the user.
    input_contexts: ?[]const InputContext = null,

    /// Configuration information, if any, for connecting an Amazon Kendra
    /// index with the `AMAZON.KendraSearchIntent` intent.
    kendra_configuration: ?KendraConfiguration = null,

    /// The date that the intent was updated.
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

    /// An array of slot types that defines the information required to
    /// fulfill the intent.
    slots: ?[]const Slot = null,

    /// The version number assigned to the new version of the
    /// intent.
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

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateIntentVersionInput, options: Options) !CreateIntentVersionOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "lexmodelbuildingservice");

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

fn serializeRequest(alloc: std.mem.Allocator, input: CreateIntentVersionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("lexmodelbuildingservice", "Lex Model Building Service", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var path_buf: std.ArrayList(u8) = .{};
    try path_buf.appendSlice(alloc, "/intents/");
    try path_buf.appendSlice(alloc, input.name);
    try path_buf.appendSlice(alloc, "/versions");
    const path = try path_buf.toOwnedSlice(alloc);

    var body_buf: std.ArrayList(u8) = .{};
    var has_prev = false;
    try body_buf.appendSlice(alloc, "{");

    if (input.checksum) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"checksum\":");
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

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !CreateIntentVersionOutput {
    var result: CreateIntentVersionOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CreateIntentVersionOutput, body, alloc);
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
