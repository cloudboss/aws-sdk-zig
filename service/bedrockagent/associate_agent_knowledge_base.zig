const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const KnowledgeBaseState = @import("knowledge_base_state.zig").KnowledgeBaseState;
const AgentKnowledgeBase = @import("agent_knowledge_base.zig").AgentKnowledgeBase;

pub const AssociateAgentKnowledgeBaseInput = struct {
    /// The unique identifier of the agent with which you want to associate the
    /// knowledge base.
    agent_id: []const u8,

    /// The version of the agent with which you want to associate the knowledge
    /// base.
    agent_version: []const u8,

    /// A description of what the agent should use the knowledge base for.
    description: []const u8,

    /// The unique identifier of the knowledge base to associate with the agent.
    knowledge_base_id: []const u8,

    /// Specifies whether to use the knowledge base or not when sending an
    /// [InvokeAgent](https://docs.aws.amazon.com/bedrock/latest/APIReference/API_agent-runtime_InvokeAgent.html) request.
    knowledge_base_state: ?KnowledgeBaseState = null,

    pub const json_field_names = .{
        .agent_id = "agentId",
        .agent_version = "agentVersion",
        .description = "description",
        .knowledge_base_id = "knowledgeBaseId",
        .knowledge_base_state = "knowledgeBaseState",
    };
};

pub const AssociateAgentKnowledgeBaseOutput = struct {
    /// Contains details about the knowledge base that has been associated with the
    /// agent.
    agent_knowledge_base: ?AgentKnowledgeBase = null,

    pub const json_field_names = .{
        .agent_knowledge_base = "agentKnowledgeBase",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: AssociateAgentKnowledgeBaseInput, options: CallOptions) !AssociateAgentKnowledgeBaseOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: AssociateAgentKnowledgeBaseInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("bedrock-agent", "Bedrock Agent", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/agents/");
    try path_buf.appendSlice(allocator, input.agent_id);
    try path_buf.appendSlice(allocator, "/agentversions/");
    try path_buf.appendSlice(allocator, input.agent_version);
    try path_buf.appendSlice(allocator, "/knowledgebases/");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"description\":");
    try aws.json.writeValue(@TypeOf(input.description), input.description, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"knowledgeBaseId\":");
    try aws.json.writeValue(@TypeOf(input.knowledge_base_id), input.knowledge_base_id, allocator, &body_buf);
    has_prev = true;
    if (input.knowledge_base_state) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"knowledgeBaseState\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !AssociateAgentKnowledgeBaseOutput {
    var result: AssociateAgentKnowledgeBaseOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(AssociateAgentKnowledgeBaseOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
