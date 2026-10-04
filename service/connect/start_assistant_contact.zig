const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AiAgentInput = @import("ai_agent_input.zig").AiAgentInput;
const ChatMessage = @import("chat_message.zig").ChatMessage;
const ParticipantDetails = @import("participant_details.zig").ParticipantDetails;
const PersistentChat = @import("persistent_chat.zig").PersistentChat;

pub const StartAssistantContactInput = struct {
    /// The AI agent configuration for this contact.
    ai_agent: AiAgentInput,

    /// A map of key-value pairs to associate with the contact. We make these
    /// attributes available to
    /// flows as standard contact attributes.
    ///
    /// You can provide up to 32,768 UTF-8 bytes across all key-value pairs for each
    /// contact.
    attributes: ?[]const aws.map.StringMapEntry = null,

    /// A unique, case-sensitive identifier that you provide to ensure the
    /// idempotency of the
    /// request. If not provided, the Amazon Web Services
    /// SDK populates this field. For more information about idempotency, see
    /// [Making retries safe with idempotent
    /// APIs](https://aws.amazon.com/builders-library/making-retries-safe-with-idempotent-APIs/).
    client_token: ?[]const u8 = null,

    /// The initial message to send to the newly created chat.
    initial_message: ?ChatMessage = null,

    /// The identifier of the Connect Customer instance. You can [find the instance
    /// ID](https://docs.aws.amazon.com/connect/latest/adminguide/find-instance-arn.html) in the Amazon Resource Name (ARN) of the instance.
    instance_id: []const u8,

    /// The display name and other details that identify the chat participant.
    participant_details: ParticipantDetails,

    /// The configuration that enables persistent chat. For more information about
    /// persistent chat and its use cases,
    /// see [Enable persistent
    /// chat](https://docs.aws.amazon.com/connect/latest/adminguide/chat-persistence.html).
    persistent_chat: ?PersistentChat = null,

    /// The identifier of an Connect Customer contact related to the new assistant
    /// contact.
    ///
    /// You cannot provide both `RelatedContactId` and `PersistentChat`.
    related_contact_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .ai_agent = "AiAgent",
        .attributes = "Attributes",
        .client_token = "ClientToken",
        .initial_message = "InitialMessage",
        .instance_id = "InstanceId",
        .participant_details = "ParticipantDetails",
        .persistent_chat = "PersistentChat",
        .related_contact_id = "RelatedContactId",
    };
};

pub const StartAssistantContactOutput = struct {
    /// The identifier of the contact within the Connect Customer instance.
    contact_id: ?[]const u8 = null,

    /// The identifier of the contact from which the chat continues, returned only
    /// for persistent chats.
    continued_from_contact_id: ?[]const u8 = null,

    /// The identifier of the chat participant. The participant identifier remains
    /// the same throughout the chat
    /// lifecycle.
    participant_id: ?[]const u8 = null,

    /// The token that the chat participant uses with the
    /// [CreateParticipantConnection](https://docs.aws.amazon.com/connect-participant/latest/APIReference/API_CreateParticipantConnection.html) operation. The token remains valid for the lifetime of the chat participant.
    participant_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .contact_id = "ContactId",
        .continued_from_contact_id = "ContinuedFromContactId",
        .participant_id = "ParticipantId",
        .participant_token = "ParticipantToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: StartAssistantContactInput, options: CallOptions) !StartAssistantContactOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "connect", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: StartAssistantContactInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("connect", "Connect", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/contact/assistant";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"AiAgent\":");
    try aws.json.writeValue(@TypeOf(input.ai_agent), input.ai_agent, allocator, &body_buf);
    has_prev = true;
    if (input.attributes) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Attributes\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.client_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"ClientToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.initial_message) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"InitialMessage\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"InstanceId\":");
    try aws.json.writeValue(@TypeOf(input.instance_id), input.instance_id, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"ParticipantDetails\":");
    try aws.json.writeValue(@TypeOf(input.participant_details), input.participant_details, allocator, &body_buf);
    has_prev = true;
    if (input.persistent_chat) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"PersistentChat\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.related_contact_id) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"RelatedContactId\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .PUT;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !StartAssistantContactOutput {
    const result: StartAssistantContactOutput = try aws.json.parseJsonObject(
        StartAssistantContactOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
