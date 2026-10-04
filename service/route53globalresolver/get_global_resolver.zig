const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const GlobalResolverIpAddressType = @import("global_resolver_ip_address_type.zig").GlobalResolverIpAddressType;
const CRResourceStatus = @import("cr_resource_status.zig").CRResourceStatus;

pub const GetGlobalResolverInput = struct {
    /// The ID of the Route 53 Global Resolver to retrieve information about.
    global_resolver_id: []const u8,

    pub const json_field_names = .{
        .global_resolver_id = "globalResolverId",
    };
};

pub const GetGlobalResolverOutput = struct {
    /// The Amazon Resource Name (ARN) of the Global Resolver.
    arn: []const u8,

    /// A unique, case-sensitive identifier to ensure idempotency. This means that
    /// making the same request multiple times with the same `clientToken` has the
    /// same result every time.
    client_token: []const u8,

    /// The date and time the Global Resolver was created.
    created_at: i64,

    /// The description of the Global Resolver.
    description: ?[]const u8 = null,

    /// The hostname used by the customers' DNS clients for certification
    /// validation.
    dns_name: []const u8,

    /// The ID of the Global Resolver.
    id: []const u8,

    /// The IP address type configured for the Global Resolver.
    ip_address_type: ?GlobalResolverIpAddressType = null,

    /// List of anycast IPv4 addresses associated with the Global Resolver instance.
    ipv_4_addresses: ?[]const []const u8 = null,

    /// List of anycast IPv6 addresses associated with the Global Resolver instance.
    /// This field is only populated when ipAddressType is DUAL_STACK.
    ipv_6_addresses: ?[]const []const u8 = null,

    /// The name of the Global Resolver.
    name: []const u8,

    /// The Amazon Web Services Regions in which the users' Global Resolver query
    /// resolution logs will be propagated.
    observability_region: ?[]const u8 = null,

    /// The Amazon Web Services Regions in which the Global Resolver operate.
    regions: ?[]const []const u8 = null,

    /// The operational status of the Global Resolver.
    status: CRResourceStatus,

    /// The date and time the Global Resolver was updated.
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

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetGlobalResolverInput, options: CallOptions) !GetGlobalResolverOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetGlobalResolverInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("route53globalresolver", "Route53GlobalResolver", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/global-resolver/");
    try path_buf.appendSlice(allocator, input.global_resolver_id);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetGlobalResolverOutput {
    var result: GetGlobalResolverOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetGlobalResolverOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
