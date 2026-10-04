const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const CustomerAgentlessCollectorInfo = @import("customer_agentless_collector_info.zig").CustomerAgentlessCollectorInfo;
const CustomerAgentInfo = @import("customer_agent_info.zig").CustomerAgentInfo;
const CustomerConnectorInfo = @import("customer_connector_info.zig").CustomerConnectorInfo;
const CustomerMeCollectorInfo = @import("customer_me_collector_info.zig").CustomerMeCollectorInfo;

pub const GetDiscoverySummaryInput = struct {
};

pub const GetDiscoverySummaryOutput = struct {
    /// Details about Agentless Collector collectors, including status.
    agentless_collector_summary: ?CustomerAgentlessCollectorInfo = null,

    /// Details about discovered agents, including agent status and health.
    agent_summary: ?CustomerAgentInfo = null,

    /// The number of applications discovered.
    applications: ?i64 = null,

    /// Details about discovered connectors, including connector status and health.
    connector_summary: ?CustomerConnectorInfo = null,

    /// Details about Migration Evaluator collectors, including collector status and
    /// health.
    me_collector_summary: ?CustomerMeCollectorInfo = null,

    /// The number of servers discovered.
    servers: ?i64 = null,

    /// The number of servers mapped to applications.
    servers_mapped_to_applications: ?i64 = null,

    /// The number of servers mapped to tags.
    servers_mappedto_tags: ?i64 = null,

    pub const json_field_names = .{
        .agentless_collector_summary = "agentlessCollectorSummary",
        .agent_summary = "agentSummary",
        .applications = "applications",
        .connector_summary = "connectorSummary",
        .me_collector_summary = "meCollectorSummary",
        .servers = "servers",
        .servers_mapped_to_applications = "serversMappedToApplications",
        .servers_mappedto_tags = "serversMappedtoTags",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetDiscoverySummaryInput, options: CallOptions) !GetDiscoverySummaryOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetDiscoverySummaryInput, config: *aws.Config) !aws.http.Request {
    _ = input;
    const endpoint = try config.getEndpointForService("discovery", "Application Discovery Service", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = "{}";

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AWSPoseidonService_V2015_11_01.GetDiscoverySummary");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetDiscoverySummaryOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(GetDiscoverySummaryOutput, body, allocator);
}
