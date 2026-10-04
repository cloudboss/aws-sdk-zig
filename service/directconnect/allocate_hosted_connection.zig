const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Tag = @import("tag.zig").Tag;
const BillingMode = @import("billing_mode.zig").BillingMode;
const ConnectionState = @import("connection_state.zig").ConnectionState;
const HasLogicalRedundancy = @import("has_logical_redundancy.zig").HasLogicalRedundancy;
const MacSecKey = @import("mac_sec_key.zig").MacSecKey;
const RateLimiterStatus = @import("rate_limiter_status.zig").RateLimiterStatus;

pub const AllocateHostedConnectionInput = struct {
    /// The bandwidth of the connection. The possible values are 50Mbps, 100Mbps,
    /// 200Mbps,
    /// 300Mbps, 400Mbps, 500Mbps, 1Gbps, 2Gbps, 5Gbps, 10Gbps, and 25Gbps. Note
    /// that only those
    /// Direct Connect Partners who have met specific requirements are allowed to
    /// create a 1Gbps, 2Gbps, 5Gbps,
    /// 10Gbps, or 25Gbps hosted connection.
    bandwidth: []const u8,

    /// The ID of the interconnect or LAG.
    connection_id: []const u8,

    /// The name of the hosted connection.
    connection_name: []const u8,

    /// The ID of the Amazon Web Services account ID of the customer for the
    /// connection.
    owner_account: []const u8,

    /// The tags associated with the connection.
    tags: ?[]const Tag = null,

    /// The dedicated VLAN provisioned to the hosted connection.
    vlan: ?i32 = null,

    pub const json_field_names = .{
        .bandwidth = "bandwidth",
        .connection_id = "connectionId",
        .connection_name = "connectionName",
        .owner_account = "ownerAccount",
        .tags = "tags",
        .vlan = "vlan",
    };
};

pub const AllocateHostedConnectionOutput = @import("connection.zig").Connection;

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: AllocateHostedConnectionInput, options: CallOptions) !AllocateHostedConnectionOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "directconnect", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: AllocateHostedConnectionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("directconnect", "Direct Connect", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "OvertureService.AllocateHostedConnection");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !AllocateHostedConnectionOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(AllocateHostedConnectionOutput, body, allocator);
}
