const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AgentDetails = @import("agent_details.zig").AgentDetails;
const DiscoveryData = @import("discovery_data.zig").DiscoveryData;

pub const RegisterAgentInput = struct {
    /// Detailed information about the agent being registered.
    agent_details: AgentDetails,

    /// Data for associating an agent with the capabilities it is managing.
    discovery_data: DiscoveryData,

    /// Tags assigned to an `Agent`.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .agent_details = "agentDetails",
        .discovery_data = "discoveryData",
        .tags = "tags",
    };
};

pub const RegisterAgentOutput = struct {
    /// UUID of registered agent.
    agent_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .agent_id = "agentId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: RegisterAgentInput, options: CallOptions) !RegisterAgentOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "groundstation", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: RegisterAgentInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("groundstation", "GroundStation", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/agent";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"agentDetails\":");
    try aws.json.writeValue(@TypeOf(input.agent_details), input.agent_details, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"discoveryData\":");
    try aws.json.writeValue(@TypeOf(input.discovery_data), input.discovery_data, allocator, &body_buf);
    has_prev = true;
    if (input.tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"tags\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !RegisterAgentOutput {
    var result: RegisterAgentOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(RegisterAgentOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
