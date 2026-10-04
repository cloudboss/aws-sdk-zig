const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const GetAgentCardInput = struct {
    /// The ARN of the AgentCore Runtime agent for which you want to get the A2A
    /// agent card.
    agent_runtime_arn: []const u8,

    /// Optional qualifier to specify an agent alias, such as `prod`code> or `dev`.
    /// If you don't provide a value, the DEFAULT alias is used.
    qualifier: ?[]const u8 = null,

    /// The session ID that the AgentCore Runtime agent is using.
    runtime_session_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .agent_runtime_arn = "agentRuntimeArn",
        .qualifier = "qualifier",
        .runtime_session_id = "runtimeSessionId",
    };
};

pub const GetAgentCardOutput = struct {
    /// An agent card document that contains metadata and capabilities for an
    /// AgentCore Runtime agent.
    agent_card: []const u8,

    /// The ID of the session associated with the AgentCore Runtime agent.
    runtime_session_id: ?[]const u8 = null,

    /// The status code of the request.
    status_code: ?i32 = null,

    pub const json_field_names = .{
        .agent_card = "agentCard",
        .runtime_session_id = "runtimeSessionId",
        .status_code = "statusCode",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetAgentCardInput, options: CallOptions) !GetAgentCardOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "bedrock-agentcore", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetAgentCardInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("bedrock-agentcore", "Bedrock AgentCore", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/runtimes/");
    try path_buf.appendSlice(allocator, input.agent_runtime_arn);
    try path_buf.appendSlice(allocator, "/invocations/.well-known/agent-card.json");
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.qualifier) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "qualifier=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    const query = try query_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    request.query = query;
    try request.headers.put(allocator, "Content-Type", "application/json");
    if (input.runtime_session_id) |v| {
        try request.headers.put(allocator, "X-Amzn-Bedrock-AgentCore-Runtime-Session-Id", v);
    }

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetAgentCardOutput {
    var result: GetAgentCardOutput = .{
        .agent_card = "",
    };
    errdefer {
        if (result.runtime_session_id) |value| allocator.free(value);
        allocator.free(result.agent_card);
    }
    result.agent_card = try allocator.dupe(u8, body);
    result.status_code = @intCast(status);
    if (headers.get("x-amzn-bedrock-agentcore-runtime-session-id")) |value| {
        result.runtime_session_id = try allocator.dupe(u8, value);
    }

    return result;
}
