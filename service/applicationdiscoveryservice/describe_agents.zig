const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Filter = @import("filter.zig").Filter;
const AgentInfo = @import("agent_info.zig").AgentInfo;

pub const DescribeAgentsInput = struct {
    /// The agent or the collector IDs for which you want information. If you
    /// specify no IDs,
    /// the system returns information about all agents/collectors associated with
    /// your user.
    agent_ids: ?[]const []const u8 = null,

    /// You can filter the request using various logical operators and a
    /// *key*-*value* format. For example:
    ///
    /// `{"key": "collectionStatus", "value": "STARTED"}`
    filters: ?[]const Filter = null,

    /// The total number of agents/collectors to return in a single page of output.
    /// The maximum
    /// value is 100.
    max_results: ?i32 = null,

    /// Token to retrieve the next set of results. For example, if you previously
    /// specified 100
    /// IDs for `DescribeAgentsRequest$agentIds` but set
    /// `DescribeAgentsRequest$maxResults` to 10, you received a set of 10 results
    /// along
    /// with a token. Use that token in this query to get the next set of 10.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .agent_ids = "agentIds",
        .filters = "filters",
        .max_results = "maxResults",
        .next_token = "nextToken",
    };
};

pub const DescribeAgentsOutput = struct {
    /// Lists agents or the collector by ID or lists all agents/collectors
    /// associated with your
    /// user, if you did not specify an agent/collector ID. The output includes
    /// agent/collector
    /// IDs, IP addresses, media access control (MAC) addresses, agent/collector
    /// health, host name
    /// where the agent/collector resides, and the version number of each
    /// agent/collector.
    agents_info: ?[]const AgentInfo = null,

    /// Token to retrieve the next set of results. For example, if you specified 100
    /// IDs for
    /// `DescribeAgentsRequest$agentIds` but set
    /// `DescribeAgentsRequest$maxResults` to 10, you received a set of 10 results
    /// along
    /// with this token. Use this token in the next query to retrieve the next set
    /// of 10.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .agents_info = "agentsInfo",
        .next_token = "nextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeAgentsInput, options: CallOptions) !DescribeAgentsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeAgentsInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AWSPoseidonService_V2015_11_01.DescribeAgents");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeAgentsOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DescribeAgentsOutput, body, allocator);
}
