const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AgentConfigurationStatus = @import("agent_configuration_status.zig").AgentConfigurationStatus;

pub const StartDataCollectionByAgentIdsInput = struct {
    /// The IDs of the agents from which to start collecting data. If you send a
    /// request to an
    /// agent ID that you do not have permission to contact, according to your
    /// Amazon Web Services account, the
    /// service does not throw an exception. Instead, it returns the error in the
    /// *Description* field. If you send a request to multiple agents and you do
    /// not have permission to contact some of those agents, the system does not
    /// throw an exception.
    /// Instead, the system shows `Failed` in the *Description*
    /// field.
    agent_ids: []const []const u8,

    pub const json_field_names = .{
        .agent_ids = "agentIds",
    };
};

pub const StartDataCollectionByAgentIdsOutput = struct {
    /// Information about agents that were instructed to start collecting data.
    /// Information
    /// includes the agent ID, a description of the operation performed, and whether
    /// the agent
    /// configuration was updated.
    agents_configuration_status: ?[]const AgentConfigurationStatus = null,

    pub const json_field_names = .{
        .agents_configuration_status = "agentsConfigurationStatus",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: StartDataCollectionByAgentIdsInput, options: CallOptions) !StartDataCollectionByAgentIdsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "discovery", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: StartDataCollectionByAgentIdsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("discovery", "Application Discovery Service", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AWSPoseidonService_V2015_11_01.StartDataCollectionByAgentIds");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !StartDataCollectionByAgentIdsOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(StartDataCollectionByAgentIdsOutput, body, allocator);
}
