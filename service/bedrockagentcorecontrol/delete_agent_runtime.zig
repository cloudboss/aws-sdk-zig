const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AgentRuntimeStatus = @import("agent_runtime_status.zig").AgentRuntimeStatus;

pub const DeleteAgentRuntimeInput = struct {
    /// The unique identifier of the AgentCore Runtime to delete.
    agent_runtime_id: []const u8,

    /// The version of the AgentCore Runtime to delete. When you provide this value,
    /// only that version is deleted. When you omit it, the entire AgentCore Runtime
    /// and all of its versions are deleted.
    agent_runtime_version: ?[]const u8 = null,

    /// A unique, case-sensitive identifier to ensure that the operation completes
    /// no more than one time. If this token matches a previous request, the service
    /// ignores the request but does not return an error.
    client_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .agent_runtime_id = "agentRuntimeId",
        .agent_runtime_version = "agentRuntimeVersion",
        .client_token = "clientToken",
    };
};

pub const DeleteAgentRuntimeOutput = struct {
    /// The unique identifier of the AgentCore Runtime.
    agent_runtime_id: ?[]const u8 = null,

    /// The version of the AgentCore Runtime that was deleted. This value is present
    /// only when you delete a single version.
    agent_runtime_version: ?[]const u8 = null,

    /// The current status of the AgentCore Runtime deletion.
    status: AgentRuntimeStatus,

    pub const json_field_names = .{
        .agent_runtime_id = "agentRuntimeId",
        .agent_runtime_version = "agentRuntimeVersion",
        .status = "status",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DeleteAgentRuntimeInput, options: CallOptions) !DeleteAgentRuntimeOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DeleteAgentRuntimeInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("bedrock-agentcore-control", "Bedrock AgentCore Control", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/runtimes/");
    try path_buf.appendSlice(allocator, input.agent_runtime_id);
    try path_buf.appendSlice(allocator, "/");
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.agent_runtime_version) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "version=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DeleteAgentRuntimeOutput {
    const result: DeleteAgentRuntimeOutput = try aws.json.parseJsonObject(
        DeleteAgentRuntimeOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
