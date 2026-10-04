const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AliasInvocationState = @import("alias_invocation_state.zig").AliasInvocationState;
const AgentAliasRoutingConfigurationListItem = @import("agent_alias_routing_configuration_list_item.zig").AgentAliasRoutingConfigurationListItem;
const AgentAlias = @import("agent_alias.zig").AgentAlias;

pub const UpdateAgentAliasInput = struct {
    /// The unique identifier of the alias.
    agent_alias_id: []const u8,

    /// Specifies a new name for the alias.
    agent_alias_name: []const u8,

    /// The unique identifier of the agent.
    agent_id: []const u8,

    /// The invocation state for the agent alias. To pause the agent alias, set the
    /// value to `REJECT_INVOCATIONS`. To start the agent alias running again, set
    /// the value to `ACCEPT_INVOCATIONS`. Use the `GetAgentAlias`, or
    /// `ListAgentAliases`, operation to get the invocation state of an agent alias.
    alias_invocation_state: ?AliasInvocationState = null,

    /// Specifies a new description for the alias.
    description: ?[]const u8 = null,

    /// Contains details about the routing configuration of the alias.
    routing_configuration: ?[]const AgentAliasRoutingConfigurationListItem = null,

    pub const json_field_names = .{
        .agent_alias_id = "agentAliasId",
        .agent_alias_name = "agentAliasName",
        .agent_id = "agentId",
        .alias_invocation_state = "aliasInvocationState",
        .description = "description",
        .routing_configuration = "routingConfiguration",
    };
};

pub const UpdateAgentAliasOutput = struct {
    /// Contains details about the alias that was updated.
    agent_alias: ?AgentAlias = null,

    pub const json_field_names = .{
        .agent_alias = "agentAlias",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateAgentAliasInput, options: CallOptions) !UpdateAgentAliasOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateAgentAliasInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("bedrock-agent", "Bedrock Agent", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/agents/");
    try path_buf.appendSlice(allocator, input.agent_id);
    try path_buf.appendSlice(allocator, "/agentaliases/");
    try path_buf.appendSlice(allocator, input.agent_alias_id);
    try path_buf.appendSlice(allocator, "/");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"agentAliasName\":");
    try aws.json.writeValue(@TypeOf(input.agent_alias_name), input.agent_alias_name, allocator, &body_buf);
    has_prev = true;
    if (input.alias_invocation_state) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"aliasInvocationState\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.description) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"description\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.routing_configuration) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"routingConfiguration\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateAgentAliasOutput {
    const result: UpdateAgentAliasOutput = try aws.json.parseJsonObject(
        UpdateAgentAliasOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
