const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AgentActionGroup = @import("agent_action_group.zig").AgentActionGroup;

pub const GetAgentActionGroupInput = struct {
    /// The unique identifier of the action group for which to get information.
    action_group_id: []const u8,

    /// The unique identifier of the agent that the action group belongs to.
    agent_id: []const u8,

    /// The version of the agent that the action group belongs to.
    agent_version: []const u8,

    pub const json_field_names = .{
        .action_group_id = "actionGroupId",
        .agent_id = "agentId",
        .agent_version = "agentVersion",
    };
};

pub const GetAgentActionGroupOutput = struct {
    /// Contains details about the action group.
    agent_action_group: ?AgentActionGroup = null,

    pub const json_field_names = .{
        .agent_action_group = "agentActionGroup",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetAgentActionGroupInput, options: CallOptions) !GetAgentActionGroupOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetAgentActionGroupInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("bedrock-agent", "Bedrock Agent", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/agents/");
    try path_buf.appendSlice(allocator, input.agent_id);
    try path_buf.appendSlice(allocator, "/agentversions/");
    try path_buf.appendSlice(allocator, input.agent_version);
    try path_buf.appendSlice(allocator, "/actiongroups/");
    try path_buf.appendSlice(allocator, input.action_group_id);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetAgentActionGroupOutput {
    var result: GetAgentActionGroupOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetAgentActionGroupOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
