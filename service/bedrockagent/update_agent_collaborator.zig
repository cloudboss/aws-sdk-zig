const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AgentDescriptor = @import("agent_descriptor.zig").AgentDescriptor;
const RelayConversationHistory = @import("relay_conversation_history.zig").RelayConversationHistory;
const AgentCollaborator = @import("agent_collaborator.zig").AgentCollaborator;

pub const UpdateAgentCollaboratorInput = struct {
    /// An agent descriptor for the agent collaborator.
    agent_descriptor: AgentDescriptor,

    /// The agent's ID.
    agent_id: []const u8,

    /// The agent's version.
    agent_version: []const u8,

    /// Instruction for the collaborator.
    collaboration_instruction: []const u8,

    /// The collaborator's ID.
    collaborator_id: []const u8,

    /// The collaborator's name.
    collaborator_name: []const u8,

    /// A relay conversation history for the collaborator.
    relay_conversation_history: ?RelayConversationHistory = null,

    pub const json_field_names = .{
        .agent_descriptor = "agentDescriptor",
        .agent_id = "agentId",
        .agent_version = "agentVersion",
        .collaboration_instruction = "collaborationInstruction",
        .collaborator_id = "collaboratorId",
        .collaborator_name = "collaboratorName",
        .relay_conversation_history = "relayConversationHistory",
    };
};

pub const UpdateAgentCollaboratorOutput = struct {
    /// Details about the collaborator.
    agent_collaborator: ?AgentCollaborator = null,

    pub const json_field_names = .{
        .agent_collaborator = "agentCollaborator",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateAgentCollaboratorInput, options: CallOptions) !UpdateAgentCollaboratorOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "bedrock", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateAgentCollaboratorInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("bedrock-agent", "Bedrock Agent", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/agents/");
    try path_buf.appendSlice(allocator, input.agent_id);
    try path_buf.appendSlice(allocator, "/agentversions/");
    try path_buf.appendSlice(allocator, input.agent_version);
    try path_buf.appendSlice(allocator, "/agentcollaborators/");
    try path_buf.appendSlice(allocator, input.collaborator_id);
    try path_buf.appendSlice(allocator, "/");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"agentDescriptor\":");
    try aws.json.writeValue(@TypeOf(input.agent_descriptor), input.agent_descriptor, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"collaborationInstruction\":");
    try aws.json.writeValue(@TypeOf(input.collaboration_instruction), input.collaboration_instruction, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"collaboratorName\":");
    try aws.json.writeValue(@TypeOf(input.collaborator_name), input.collaborator_name, allocator, &body_buf);
    has_prev = true;
    if (input.relay_conversation_history) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"relayConversationHistory\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateAgentCollaboratorOutput {
    var result: UpdateAgentCollaboratorOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(UpdateAgentCollaboratorOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
