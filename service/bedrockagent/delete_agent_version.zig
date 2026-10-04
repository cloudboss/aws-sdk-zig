const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AgentStatus = @import("agent_status.zig").AgentStatus;

pub const DeleteAgentVersionInput = struct {
    /// The unique identifier of the agent that the version belongs to.
    agent_id: []const u8,

    /// The version of the agent to delete.
    agent_version: []const u8,

    /// By default, this value is `false` and deletion is stopped if the resource is
    /// in use. If you set it to `true`, the resource will be deleted even if the
    /// resource is in use.
    skip_resource_in_use_check: ?bool = null,

    pub const json_field_names = .{
        .agent_id = "agentId",
        .agent_version = "agentVersion",
        .skip_resource_in_use_check = "skipResourceInUseCheck",
    };
};

pub const DeleteAgentVersionOutput = struct {
    /// The unique identifier of the agent that the version belongs to.
    agent_id: []const u8,

    /// The status of the agent version.
    agent_status: AgentStatus,

    /// The version that was deleted.
    agent_version: []const u8,

    pub const json_field_names = .{
        .agent_id = "agentId",
        .agent_status = "agentStatus",
        .agent_version = "agentVersion",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DeleteAgentVersionInput, options: CallOptions) !DeleteAgentVersionOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DeleteAgentVersionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("bedrock-agent", "Bedrock Agent", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/agents/");
    try path_buf.appendSlice(allocator, input.agent_id);
    try path_buf.appendSlice(allocator, "/agentversions/");
    try path_buf.appendSlice(allocator, input.agent_version);
    try path_buf.appendSlice(allocator, "/");
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.skip_resource_in_use_check) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "skipResourceInUseCheck=");
        try query_buf.appendSlice(allocator, if (v) "true" else "false");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DeleteAgentVersionOutput {
    var result: DeleteAgentVersionOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(DeleteAgentVersionOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
