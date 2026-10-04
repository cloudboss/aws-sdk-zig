const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AgentAlias = @import("agent_alias.zig").AgentAlias;

pub const GetAgentAliasInput = struct {
    /// The unique identifier of the alias for which to get information.
    agent_alias_id: []const u8,

    /// The unique identifier of the agent to which the alias to get information
    /// belongs.
    agent_id: []const u8,

    pub const json_field_names = .{
        .agent_alias_id = "agentAliasId",
        .agent_id = "agentId",
    };
};

pub const GetAgentAliasOutput = struct {
    /// Contains information about the alias.
    agent_alias: ?AgentAlias = null,

    pub const json_field_names = .{
        .agent_alias = "agentAlias",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetAgentAliasInput, options: CallOptions) !GetAgentAliasOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetAgentAliasInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("bedrock-agent", "Bedrock Agent", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/agents/");
    try path_buf.appendSlice(allocator, input.agent_id);
    try path_buf.appendSlice(allocator, "/agentaliases/");
    try path_buf.appendSlice(allocator, input.agent_alias_id);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetAgentAliasOutput {
    const result: GetAgentAliasOutput = try aws.json.parseJsonObject(
        GetAgentAliasOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
