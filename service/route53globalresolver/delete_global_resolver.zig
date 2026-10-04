const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const GlobalResolverIpAddressType = @import("global_resolver_ip_address_type.zig").GlobalResolverIpAddressType;
const CRResourceStatus = @import("cr_resource_status.zig").CRResourceStatus;

pub const DeleteGlobalResolverInput = struct {
    /// The unique identifier of the Route 53 Global Resolver to delete.
    global_resolver_id: []const u8,

    pub const json_field_names = .{
        .global_resolver_id = "globalResolverId",
    };
};

pub const DeleteGlobalResolverOutput = struct {
    /// The Amazon Resource Name (ARN) of the deleted Route 53 Global Resolver.
    arn: []const u8,

    /// The unique string that identifies the request and ensures idempotency.
    client_token: []const u8,

    /// The date and time when the Route 53 Global Resolver was originally created.
    created_at: i64,

    /// The description of the deleted Route 53 Global Resolver.
    description: ?[]const u8 = null,

    /// The hostname that DNS clients used for TLS certificate validation when
    /// connecting to the deleted Route 53 Global Resolver.
    dns_name: []const u8,

    /// The unique identifier of the deleted Route 53 Global Resolver.
    id: []const u8,

    /// The IP address type that was configured for the deleted Route 53 Global
    /// Resolver.
    ip_address_type: ?GlobalResolverIpAddressType = null,

    /// The global anycast IPv4 addresses that were associated with the deleted
    /// Route 53 Global Resolver.
    ipv_4_addresses: ?[]const []const u8 = null,

    /// The global anycast IPv6 addresses that were associated with the deleted
    /// Route 53 Global Resolver.
    ipv_6_addresses: ?[]const []const u8 = null,

    /// The name of the deleted Route 53 Global Resolver.
    name: []const u8,

    /// The Amazon Web Services Region where observability data for the deleted
    /// Route 53 Global Resolver was stored.
    observability_region: ?[]const u8 = null,

    /// The Amazon Web Services Regions where the deleted Route 53 Global Resolver
    /// was deployed and operational.
    regions: ?[]const []const u8 = null,

    /// The final status of the deleted Route 53 Global Resolver.
    status: CRResourceStatus,

    /// The date and time when the Route 53 Global Resolver was last updated before
    /// deletion.
    updated_at: i64,

    pub const json_field_names = .{
        .arn = "arn",
        .client_token = "clientToken",
        .created_at = "createdAt",
        .description = "description",
        .dns_name = "dnsName",
        .id = "id",
        .ip_address_type = "ipAddressType",
        .ipv_4_addresses = "ipv4Addresses",
        .ipv_6_addresses = "ipv6Addresses",
        .name = "name",
        .observability_region = "observabilityRegion",
        .regions = "regions",
        .status = "status",
        .updated_at = "updatedAt",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DeleteGlobalResolverInput, options: CallOptions) !DeleteGlobalResolverOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "route53globalresolver", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DeleteGlobalResolverInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("route53globalresolver", "Route53GlobalResolver", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/global-resolver/");
    try path_buf.appendSlice(allocator, input.global_resolver_id);
    const path = try path_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .DELETE;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DeleteGlobalResolverOutput {
    var result: DeleteGlobalResolverOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(DeleteGlobalResolverOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
