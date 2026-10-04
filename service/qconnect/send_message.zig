const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const MessageConfiguration = @import("message_configuration.zig").MessageConfiguration;
const ConversationContext = @import("conversation_context.zig").ConversationContext;
const MessageInput = @import("message_input.zig").MessageInput;
const MessageType = @import("message_type.zig").MessageType;

pub const SendMessageInput = struct {
    /// The identifier of the AI Agent to use for processing the message.
    ai_agent_id: ?[]const u8 = null,

    /// The identifier of the Amazon Q in Connect assistant.
    assistant_id: []const u8,

    /// A unique, case-sensitive identifier that you provide to ensure the
    /// idempotency of the request. If not provided, the AWS SDK populates this
    /// field.For more information about idempotency, see Making retries safe with
    /// idempotent APIs.
    client_token: ?[]const u8 = null,

    /// The configuration of the
    /// [SendMessage](https://docs.aws.amazon.com/connect/latest/APIReference/API_amazon-q-connect_SendMessage.html) request.
    configuration: ?MessageConfiguration = null,

    /// The conversation context before the Amazon Q in Connect session.
    conversation_context: ?ConversationContext = null,

    /// The message data to submit to the Amazon Q in Connect session.
    message: MessageInput,

    /// Additional metadata for the message.
    metadata: ?[]const aws.map.StringMapEntry = null,

    /// The orchestrator use case for message processing.
    orchestrator_use_case: ?[]const u8 = null,

    /// Request identifier from the origin system, used for end-to-end tracing
    /// across spans.
    origin_request_id: ?[]const u8 = null,

    /// The identifier of the Amazon Q in Connect session.
    session_id: []const u8,

    /// The message type.
    @"type": MessageType,

    pub const json_field_names = .{
        .ai_agent_id = "aiAgentId",
        .assistant_id = "assistantId",
        .client_token = "clientToken",
        .configuration = "configuration",
        .conversation_context = "conversationContext",
        .message = "message",
        .metadata = "metadata",
        .orchestrator_use_case = "orchestratorUseCase",
        .origin_request_id = "originRequestId",
        .session_id = "sessionId",
        .@"type" = "type",
    };
};

pub const SendMessageOutput = struct {
    /// The configuration of the
    /// [SendMessage](https://docs.aws.amazon.com/connect/latest/APIReference/API_amazon-q-connect_SendMessage.html) request.
    configuration: ?MessageConfiguration = null,

    /// The token for the next message, used by GetNextMessage.
    next_message_token: []const u8,

    /// The identifier of the submitted message.
    request_message_id: []const u8,

    pub const json_field_names = .{
        .configuration = "configuration",
        .next_message_token = "nextMessageToken",
        .request_message_id = "requestMessageId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: SendMessageInput, options: CallOptions) !SendMessageOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "wisdom", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: SendMessageInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("wisdom", "QConnect", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/assistants/");
    try path_buf.appendSlice(allocator, input.assistant_id);
    try path_buf.appendSlice(allocator, "/sessions/");
    try path_buf.appendSlice(allocator, input.session_id);
    try path_buf.appendSlice(allocator, "/message");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.ai_agent_id) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"aiAgentId\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.client_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"clientToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.configuration) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"configuration\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.conversation_context) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"conversationContext\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"message\":");
    try aws.json.writeValue(@TypeOf(input.message), input.message, allocator, &body_buf);
    has_prev = true;
    if (input.metadata) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"metadata\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.orchestrator_use_case) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"orchestratorUseCase\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.origin_request_id) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"originRequestId\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"type\":");
    try aws.json.writeValue(@TypeOf(input.@"type"), input.@"type", allocator, &body_buf);
    has_prev = true;

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !SendMessageOutput {
    const result: SendMessageOutput = try aws.json.parseJsonObject(
        SendMessageOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
