const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;

/// Creates a route in a route table within a VPC.
///
/// You must specify either a destination CIDR block or a prefix list ID. You
/// must also specify
/// exactly one of the resources from the parameter list.
///
/// When determining how to route traffic, we use the route with the most
/// specific match.
/// For example, traffic is destined for the IPv4 address `192.0.2.3`, and the
/// route table includes the following two IPv4 routes:
///
/// * `192.0.2.0/24` (goes to some target A)
///
/// * `192.0.2.0/28` (goes to some target B)
///
/// Both routes apply to the traffic destined for `192.0.2.3`. However, the
/// second route
/// in the list covers a smaller number of IP addresses and is therefore more
/// specific,
/// so we use that route to determine where to target the traffic.
///
/// For more information about route tables, see [Route
/// tables](https://docs.aws.amazon.com/vpc/latest/userguide/VPC_Route_Tables.html) in the
/// *Amazon VPC User Guide*.
pub const CreateRouteInput = struct {
    /// The ID of the carrier gateway.
    ///
    /// You can only use this option when the VPC contains a subnet which is
    /// associated with a Wavelength Zone.
    carrier_gateway_id: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the core network.
    core_network_arn: ?[]const u8 = null,

    /// The IPv4 CIDR address block used for the destination match. Routing
    /// decisions are based on the most specific match. We modify the specified CIDR
    /// block to its canonical form; for example, if you specify `100.68.0.18/18`,
    /// we modify it to `100.68.0.0/18`.
    destination_cidr_block: ?[]const u8 = null,

    /// The IPv6 CIDR block used for the destination match. Routing decisions are
    /// based on the most specific match.
    destination_ipv_6_cidr_block: ?[]const u8 = null,

    /// The ID of a prefix list used for the destination match.
    destination_prefix_list_id: ?[]const u8 = null,

    /// Checks whether you have the required permissions for the action, without
    /// actually making the request,
    /// and provides an error response. If you have the required permissions, the
    /// error response is `DryRunOperation`.
    /// Otherwise, it is `UnauthorizedOperation`.
    dry_run: ?bool = null,

    /// [IPv6 traffic only] The ID of an egress-only internet gateway.
    egress_only_internet_gateway_id: ?[]const u8 = null,

    /// The ID of an internet gateway or virtual private gateway attached to your
    /// VPC.
    gateway_id: ?[]const u8 = null,

    /// The ID of a NAT instance in your VPC. The operation fails if you specify an
    /// instance ID unless exactly one network interface is attached.
    instance_id: ?[]const u8 = null,

    /// The ID of the local gateway.
    local_gateway_id: ?[]const u8 = null,

    /// [IPv4 traffic only] The ID of a NAT gateway.
    nat_gateway_id: ?[]const u8 = null,

    /// The ID of a network interface.
    network_interface_id: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the ODB network.
    odb_network_arn: ?[]const u8 = null,

    /// The ID of the route table for the route.
    route_table_id: []const u8,

    /// The ID of a transit gateway.
    transit_gateway_id: ?[]const u8 = null,

    /// The ID of a VPC endpoint. Supported for Gateway Load Balancer endpoints
    /// only.
    vpc_endpoint_id: ?[]const u8 = null,

    /// The ID of a VPC peering connection.
    vpc_peering_connection_id: ?[]const u8 = null,
};

pub const CreateRouteOutput = struct {
    /// Returns `true` if the request succeeds; otherwise, it returns an error.
    @"return": ?bool = null,

    allocator: std.mem.Allocator,

    pub fn deinit(self: *const CreateRouteOutput) void {
        _ = self;
    }
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, input: CreateRouteInput, options: Options) !CreateRouteOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "ec2");

    var response = try client.http_client.sendRequest(&request);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = parseErrorResponse(response.body, response.status);
        }
        return error.ServiceError;
    }

    return try deserializeResponse(response.body, response.status, client.allocator);
}

fn serializeRequest(alloc: std.mem.Allocator, input: CreateRouteInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpoint("ec2", alloc);

    const host = parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = parsePort(endpoint);

    var body_buf: std.ArrayList(u8) = .{};

    try body_buf.appendSlice(alloc, "Action=CreateRoute&Version=2016-11-15");
    if (input.carrier_gateway_id) |v| {
        try body_buf.appendSlice(alloc, "&CarrierGatewayId=");
        try appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.core_network_arn) |v| {
        try body_buf.appendSlice(alloc, "&CoreNetworkArn=");
        try appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.destination_cidr_block) |v| {
        try body_buf.appendSlice(alloc, "&DestinationCidrBlock=");
        try appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.destination_ipv_6_cidr_block) |v| {
        try body_buf.appendSlice(alloc, "&DestinationIpv6CidrBlock=");
        try appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.destination_prefix_list_id) |v| {
        try body_buf.appendSlice(alloc, "&DestinationPrefixListId=");
        try appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.dry_run) |v| {
        try body_buf.appendSlice(alloc, "&DryRun=");
        try appendUrlEncoded(alloc, &body_buf, if (v) "true" else "false");
    }
    if (input.egress_only_internet_gateway_id) |v| {
        try body_buf.appendSlice(alloc, "&EgressOnlyInternetGatewayId=");
        try appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.gateway_id) |v| {
        try body_buf.appendSlice(alloc, "&GatewayId=");
        try appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.instance_id) |v| {
        try body_buf.appendSlice(alloc, "&InstanceId=");
        try appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.local_gateway_id) |v| {
        try body_buf.appendSlice(alloc, "&LocalGatewayId=");
        try appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.nat_gateway_id) |v| {
        try body_buf.appendSlice(alloc, "&NatGatewayId=");
        try appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.network_interface_id) |v| {
        try body_buf.appendSlice(alloc, "&NetworkInterfaceId=");
        try appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.odb_network_arn) |v| {
        try body_buf.appendSlice(alloc, "&OdbNetworkArn=");
        try appendUrlEncoded(alloc, &body_buf, v);
    }
    try body_buf.appendSlice(alloc, "&RouteTableId=");
    try appendUrlEncoded(alloc, &body_buf, input.route_table_id);
    if (input.transit_gateway_id) |v| {
        try body_buf.appendSlice(alloc, "&TransitGatewayId=");
        try appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.vpc_endpoint_id) |v| {
        try body_buf.appendSlice(alloc, "&VpcEndpointId=");
        try appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.vpc_peering_connection_id) |v| {
        try body_buf.appendSlice(alloc, "&VpcPeeringConnectionId=");
        try appendUrlEncoded(alloc, &body_buf, v);
    }

    const body = try body_buf.toOwnedSlice(alloc);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = "/";
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(alloc, "Content-Type", "application/x-www-form-urlencoded");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, alloc: std.mem.Allocator) !CreateRouteOutput {
    _ = status;
    var result: CreateRouteOutput = .{ .allocator = alloc };
    if (findElement(body, "return")) |content| {
        result.@"return" = std.mem.eql(u8, content, "true");
    }

    return result;
}

fn parseErrorResponse(body: []const u8, status: u16) ServiceError {
    const error_code = findElement(body, "Code") orelse "Unknown";
    const error_message = findElement(body, "Message") orelse "";
    const request_id = findElement(body, "RequestID") orelse "";


    return .{ .unknown = .{
        .code = error_code,
        .message = error_message,
        .request_id = request_id,
        .http_status = status,
    } };
}

fn findElement(xml: []const u8, tag_name: []const u8) ?[]const u8 {
    var buf: [256]u8 = undefined;

    const open_tag = std.fmt.bufPrint(&buf, "<{s}>", .{tag_name}) catch return null;
    const start = std.mem.indexOf(u8, xml, open_tag) orelse return null;
    const content_start = start + open_tag.len;

    var close_buf: [256]u8 = undefined;
    const close_tag = std.fmt.bufPrint(&close_buf, "</{s}>", .{tag_name}) catch return null;
    const end = std.mem.indexOfPos(u8, xml, content_start, close_tag) orelse return null;

    return xml[content_start..end];
}

fn appendUrlEncoded(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const u8) !void {
    for (value) |c| {
        switch (c) {
            'A'...'Z', 'a'...'z', '0'...'9', '-', '_', '.', '~' => try buf.append(alloc, c),
            ' ' => try buf.append(alloc, '+'),
            else => {
                const hex = "0123456789ABCDEF";
                try buf.append(alloc, '%');
                try buf.append(alloc, hex[c >> 4]);
                try buf.append(alloc, hex[c & 0x0F]);
            }
        }
    }
}

fn parseHost(endpoint: []const u8) []const u8 {
    // Strip scheme
    const after_scheme = if (std.mem.indexOf(u8, endpoint, "://")) |idx| endpoint[idx + 3 ..] else endpoint;
    // Strip port and path
    const end = std.mem.indexOfAny(u8, after_scheme, ":/") orelse after_scheme.len;
    return after_scheme[0..end];
}

fn parsePort(endpoint: []const u8) ?u16 {
    const after_scheme = if (std.mem.indexOf(u8, endpoint, "://")) |idx| endpoint[idx + 3 ..] else endpoint;
    const colon = std.mem.indexOfScalar(u8, after_scheme, ':') orelse return null;
    const port_end = std.mem.indexOfScalarPos(u8, after_scheme, colon + 1, '/') orelse after_scheme.len;
    return std.fmt.parseInt(u16, after_scheme[colon + 1 .. port_end], 10) catch null;
}
