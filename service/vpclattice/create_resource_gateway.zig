const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ResourceGatewayIpAddressType = @import("resource_gateway_ip_address_type.zig").ResourceGatewayIpAddressType;
const ResourceConfigDnsResolution = @import("resource_config_dns_resolution.zig").ResourceConfigDnsResolution;
const ResourceGatewayStatus = @import("resource_gateway_status.zig").ResourceGatewayStatus;

pub const CreateResourceGatewayInput = struct {
    /// A unique, case-sensitive identifier that you provide to ensure the
    /// idempotency of the request. If you retry a request that completed
    /// successfully using the same client token and parameters, the retry succeeds
    /// without performing any actions. If the parameters aren't identical, the
    /// retry fails.
    client_token: ?[]const u8 = null,

    /// A resource gateway can have IPv4, IPv6 or dualstack addresses. The IP
    /// address type of a resource gateway must be compatible with the subnets of
    /// the resource gateway and the IP address type of the resource, as described
    /// here:
    ///
    /// * **IPv4**Assign IPv4 addresses to your resource gateway network interfaces.
    ///   This option is supported only if all selected subnets have IPv4 address
    ///   ranges, and the resource also has an IPv4 address.
    /// * **IPv6**Assign IPv6 addresses to your resource gateway network interfaces.
    ///   This option is supported only if all selected subnets are IPv6 only
    ///   subnets, and the resource also has an IPv6 address.
    /// * **Dualstack**Assign both IPv4 and IPv6 addresses to your resource gateway
    ///   network interfaces. This option is supported only if all selected subnets
    ///   have both IPv4 and IPv6 address ranges, and the resource either has an
    ///   IPv4 or IPv6 address.
    ///
    /// The IP address type of the resource gateway is independent of the IP address
    /// type of the client or the VPC endpoint through which the resource is
    /// accessed.
    ip_address_type: ?ResourceGatewayIpAddressType = null,

    /// The number of IPv4 addresses in each ENI for the resource gateway.
    ipv_4_addresses_per_eni: ?i32 = null,

    /// The name of the resource gateway.
    name: []const u8,

    /// Indicates how DNS is resolved for resource configurations associated to this
    /// resource gateway. ResourceConfigDnsResolution is set at creation time and
    /// cannot be changed.
    ///
    /// * `IN_VPC` - DNS resolution occurs privately within the resource gateway's
    ///   VPC. DNS queries for resources behind this resource gateway resolve using
    ///   the DNS resolvers defined in the VPC's DHCP option sets. Use this when
    ///   your resource domain names are hosted in private Route 53 hosted zones or
    ///   on-premises DNS servers reachable from the VPC.
    /// * `PUBLIC` - DNS resolution occurs against public DNS resolvers. DNS queries
    ///   for resources behind this resource gateway resolve using standard public
    ///   DNS. Use this when your resource domain names are publicly resolvable.
    resource_config_dns_resolution: ?ResourceConfigDnsResolution = null,

    /// The IDs of the security groups to apply to the resource gateway. The
    /// security groups must be in the same VPC.
    security_group_ids: ?[]const []const u8 = null,

    /// The IDs of the VPC subnets in which to create the resource gateway.
    subnet_ids: ?[]const []const u8 = null,

    /// The tags for the resource gateway.
    tags: ?[]const aws.map.StringMapEntry = null,

    /// The ID of the VPC for the resource gateway.
    vpc_identifier: ?[]const u8 = null,

    pub const json_field_names = .{
        .client_token = "clientToken",
        .ip_address_type = "ipAddressType",
        .ipv_4_addresses_per_eni = "ipv4AddressesPerEni",
        .name = "name",
        .resource_config_dns_resolution = "resourceConfigDnsResolution",
        .security_group_ids = "securityGroupIds",
        .subnet_ids = "subnetIds",
        .tags = "tags",
        .vpc_identifier = "vpcIdentifier",
    };
};

pub const CreateResourceGatewayOutput = struct {
    /// The Amazon Resource Name (ARN) of the resource gateway.
    arn: ?[]const u8 = null,

    /// The ID of the resource gateway.
    id: ?[]const u8 = null,

    /// The type of IP address for the resource gateway.
    ip_address_type: ?ResourceGatewayIpAddressType = null,

    /// The number of IPv4 addresses in each ENI for the resource gateway.
    ipv_4_addresses_per_eni: ?i32 = null,

    /// The name of the resource gateway.
    name: ?[]const u8 = null,

    /// The DNS resolution type for resource configurations that are associated with
    /// this resource gateway.
    resource_config_dns_resolution: ?ResourceConfigDnsResolution = null,

    /// The IDs of the security groups for the resource gateway.
    security_group_ids: ?[]const []const u8 = null,

    /// The status of the resource gateway.
    status: ?ResourceGatewayStatus = null,

    /// The IDs of the resource gateway subnets.
    subnet_ids: ?[]const []const u8 = null,

    /// The ID of the VPC.
    vpc_identifier: ?[]const u8 = null,

    pub const json_field_names = .{
        .arn = "arn",
        .id = "id",
        .ip_address_type = "ipAddressType",
        .ipv_4_addresses_per_eni = "ipv4AddressesPerEni",
        .name = "name",
        .resource_config_dns_resolution = "resourceConfigDnsResolution",
        .security_group_ids = "securityGroupIds",
        .status = "status",
        .subnet_ids = "subnetIds",
        .vpc_identifier = "vpcIdentifier",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateResourceGatewayInput, options: CallOptions) !CreateResourceGatewayOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "vpc-lattice", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateResourceGatewayInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("vpc-lattice", "VPC Lattice", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/resourcegateways";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.client_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"clientToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.ip_address_type) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"ipAddressType\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.ipv_4_addresses_per_eni) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"ipv4AddressesPerEni\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"name\":");
    try aws.json.writeValue(@TypeOf(input.name), input.name, allocator, &body_buf);
    has_prev = true;
    if (input.resource_config_dns_resolution) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"resourceConfigDnsResolution\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.security_group_ids) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"securityGroupIds\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.subnet_ids) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"subnetIds\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"tags\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.vpc_identifier) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"vpcIdentifier\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateResourceGatewayOutput {
    var result: CreateResourceGatewayOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CreateResourceGatewayOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
