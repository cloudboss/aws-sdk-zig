const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AgentRuntimeEndpointStatus = @import("agent_runtime_endpoint_status.zig").AgentRuntimeEndpointStatus;

pub const DeleteAgentRuntimeEndpointInput = struct {
    /// The unique identifier of the AgentCore Runtime associated with the endpoint.
    agent_runtime_id: []const u8,

    /// A unique, case-sensitive identifier to ensure idempotency of the request.
    client_token: ?[]const u8 = null,

    /// The name of the AgentCore Runtime endpoint to delete.
    endpoint_name: []const u8,

    pub const json_field_names = .{
        .agent_runtime_id = "agentRuntimeId",
        .client_token = "clientToken",
        .endpoint_name = "endpointName",
    };
};

pub const DeleteAgentRuntimeEndpointOutput = struct {
    /// The unique identifier of the AgentCore Runtime.
    agent_runtime_id: ?[]const u8 = null,

    /// The name of the AgentCore Runtime endpoint.
    endpoint_name: ?[]const u8 = null,

    /// The current status of the AgentCore Runtime endpoint deletion.
    status: AgentRuntimeEndpointStatus,

    pub const json_field_names = .{
        .agent_runtime_id = "agentRuntimeId",
        .endpoint_name = "endpointName",
        .status = "status",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DeleteAgentRuntimeEndpointInput, options: CallOptions) !DeleteAgentRuntimeEndpointOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DeleteAgentRuntimeEndpointInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("bedrock-agentcore-control", "Bedrock AgentCore Control", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/runtimes/");
    try path_buf.appendSlice(allocator, input.agent_runtime_id);
    try path_buf.appendSlice(allocator, "/runtime-endpoints/");
    try path_buf.appendSlice(allocator, input.endpoint_name);
    try path_buf.appendSlice(allocator, "/");
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.client_token) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "clientToken=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    const query = try query_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .DELETE;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    request.query = query;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DeleteAgentRuntimeEndpointOutput {
    const result: DeleteAgentRuntimeEndpointOutput = try aws.json.parseJsonObject(
        DeleteAgentRuntimeEndpointOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
