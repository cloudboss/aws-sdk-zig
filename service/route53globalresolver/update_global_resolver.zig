const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const GlobalResolverIpAddressType = @import("global_resolver_ip_address_type.zig").GlobalResolverIpAddressType;
const CRResourceStatus = @import("cr_resource_status.zig").CRResourceStatus;

pub const UpdateGlobalResolverInput = struct {
    /// The description of the Global Resolver.
    description: ?[]const u8 = null,

    /// The ID of the Global Resolver.
    global_resolver_id: []const u8,

    /// The IP address type for the Global Resolver. Valid values are IPV4 or
    /// DUAL_STACK for both IPv4 and IPv6 support.
    ip_address_type: ?GlobalResolverIpAddressType = null,

    /// The name of the Global Resolver.
    name: ?[]const u8 = null,

    /// The Amazon Web Services Regions in which the users' Global Resolver query
    /// resolution logs will be propagated.
    observability_region: ?[]const u8 = null,

    /// The list of Amazon Web Services Regions where the Global Resolver will
    /// operate. The resolver will be distributed across these Regions to provide
    /// global availability and low-latency DNS resolution.
    regions: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .description = "description",
        .global_resolver_id = "globalResolverId",
        .ip_address_type = "ipAddressType",
        .name = "name",
        .observability_region = "observabilityRegion",
        .regions = "regions",
    };
};

pub const UpdateGlobalResolverOutput = struct {
    /// The Amazon Resource Name (ARN) of the Global Resolver.
    arn: []const u8,

    /// A unique, case-sensitive identifier to ensure idempotency. This means that
    /// making the same request multiple times with the same `clientToken` has the
    /// same result every time.
    client_token: []const u8,

    /// The time and date the Global Resolverwas created.
    created_at: i64,

    /// Description of the Global Resolver.
    description: ?[]const u8 = null,

    /// The hostname to be used by the customers' DNS clients for certification
    /// validation.
    dns_name: []const u8,

    /// The ID of the Global Resolver.
    id: []const u8,

    /// The IP address type configured for the updated Global Resolver.
    ip_address_type: ?GlobalResolverIpAddressType = null,

    /// List of anycast IPv4 addresses associated with the Global Resolver instance.
    ipv_4_addresses: ?[]const []const u8 = null,

    /// List of anycast IPv6 addresses associated with the updated Global Resolver
    /// instance. This field is only populated when ipAddressType is DUAL_STACK.
    ipv_6_addresses: ?[]const []const u8 = null,

    /// Name of the Global Resolver.
    name: []const u8,

    /// The Amazon Web Services Regions in which the users' Global Resolver query
    /// resolution logs will be propagated.
    observability_region: ?[]const u8 = null,

    /// The Amazon Web Services Regions in which the Global Resolver will operate.
    regions: ?[]const []const u8 = null,

    /// The operational status of the Global Resolver.
    status: CRResourceStatus,

    /// The time and date the Global Resolver was updated.
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

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateGlobalResolverInput, options: CallOptions) !UpdateGlobalResolverOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateGlobalResolverInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("route53globalresolver", "Route53GlobalResolver", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/global-resolver/");
    try path_buf.appendSlice(allocator, input.global_resolver_id);
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.description) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"description\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.ip_address_type) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"ipAddressType\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.name) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"name\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.observability_region) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"observabilityRegion\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.regions) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"regions\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .PATCH;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateGlobalResolverOutput {
    var result: UpdateGlobalResolverOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(UpdateGlobalResolverOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
