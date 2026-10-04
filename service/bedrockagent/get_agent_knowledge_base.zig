const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AgentKnowledgeBase = @import("agent_knowledge_base.zig").AgentKnowledgeBase;

pub const GetAgentKnowledgeBaseInput = struct {
    /// The unique identifier of the agent with which the knowledge base is
    /// associated.
    agent_id: []const u8,

    /// The version of the agent with which the knowledge base is associated.
    agent_version: []const u8,

    /// The unique identifier of the knowledge base associated with the agent.
    knowledge_base_id: []const u8,

    pub const json_field_names = .{
        .agent_id = "agentId",
        .agent_version = "agentVersion",
        .knowledge_base_id = "knowledgeBaseId",
    };
};

pub const GetAgentKnowledgeBaseOutput = struct {
    /// Contains details about a knowledge base attached to an agent.
    agent_knowledge_base: ?AgentKnowledgeBase = null,

    pub const json_field_names = .{
        .agent_knowledge_base = "agentKnowledgeBase",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetAgentKnowledgeBaseInput, options: CallOptions) !GetAgentKnowledgeBaseOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetAgentKnowledgeBaseInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("bedrock-agent", "Bedrock Agent", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/agents/");
    try path_buf.appendSlice(allocator, input.agent_id);
    try path_buf.appendSlice(allocator, "/agentversions/");
    try path_buf.appendSlice(allocator, input.agent_version);
    try path_buf.appendSlice(allocator, "/knowledgebases/");
    try path_buf.appendSlice(allocator, input.knowledge_base_id);
    try path_buf.appendSlice(allocator, "/");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetAgentKnowledgeBaseOutput {
    var result: GetAgentKnowledgeBaseOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetAgentKnowledgeBaseOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
