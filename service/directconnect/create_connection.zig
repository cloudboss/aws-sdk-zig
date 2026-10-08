const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const RequestBillingMode = @import("request_billing_mode.zig").RequestBillingMode;
const Tag = @import("tag.zig").Tag;
const BillingMode = @import("billing_mode.zig").BillingMode;
const ConnectionState = @import("connection_state.zig").ConnectionState;
const HasLogicalRedundancy = @import("has_logical_redundancy.zig").HasLogicalRedundancy;
const MacSecKey = @import("mac_sec_key.zig").MacSecKey;
const RateLimiterStatus = @import("rate_limiter_status.zig").RateLimiterStatus;

pub const CreateConnectionInput = struct {
    /// The bandwidth of the connection.
    bandwidth: []const u8,

    /// The billing mode for the connection.
    billing_mode: ?RequestBillingMode = null,

    /// The name of the connection.
    connection_name: []const u8,

    /// The ID of the LAG.
    lag_id: ?[]const u8 = null,

    /// The location of the connection.
    location: []const u8,

    /// The name of the service provider associated with the requested connection.
    provider_name: ?[]const u8 = null,

    /// Indicates whether you want the connection to support MAC Security (MACsec).
    ///
    /// MAC Security (MACsec) is unavailable on hosted connections. For information
    /// about MAC Security (MACsec) prerequisites, see [MAC Security in Direct
    /// Connect](https://docs.aws.amazon.com/directconnect/latest/UserGuide/MACSec.html) in the *Direct Connect User Guide*.
    request_mac_sec: ?bool = null,

    /// The tags to associate with the lag.
    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .bandwidth = "bandwidth",
        .billing_mode = "billingMode",
        .connection_name = "connectionName",
        .lag_id = "lagId",
        .location = "location",
        .provider_name = "providerName",
        .request_mac_sec = "requestMACSec",
        .tags = "tags",
    };
};

pub const CreateConnectionOutput = @import("connection.zig").Connection;

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateConnectionInput, options: CallOptions) !CreateConnectionOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateConnectionInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "OvertureService.CreateConnection");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateConnectionOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreateConnectionOutput, body, allocator);
}
