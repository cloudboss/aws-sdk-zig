const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;

pub const ReplaceRouteInput = struct {
    /// [IPv4 traffic only] The ID of a carrier gateway.
    carrier_gateway_id: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the core network.
    core_network_arn: ?[]const u8 = null,

    /// The IPv4 CIDR address block used for the destination match. The value that
    /// you
    /// provide must match the CIDR of an existing route in the table.
    destination_cidr_block: ?[]const u8 = null,

    /// The IPv6 CIDR address block used for the destination match. The value that
    /// you
    /// provide must match the CIDR of an existing route in the table.
    destination_ipv_6_cidr_block: ?[]const u8 = null,

    /// The ID of the prefix list for the route.
    destination_prefix_list_id: ?[]const u8 = null,

    /// Checks whether you have the required permissions for the action, without
    /// actually making the request,
    /// and provides an error response. If you have the required permissions, the
    /// error response is `DryRunOperation`.
    /// Otherwise, it is `UnauthorizedOperation`.
    dry_run: ?bool = null,

    /// [IPv6 traffic only] The ID of an egress-only internet gateway.
    egress_only_internet_gateway_id: ?[]const u8 = null,

    /// The ID of an internet gateway or virtual private gateway.
    gateway_id: ?[]const u8 = null,

    /// The ID of a NAT instance in your VPC.
    instance_id: ?[]const u8 = null,

    /// The ID of the local gateway.
    local_gateway_id: ?[]const u8 = null,

    /// Specifies whether to reset the local route to its default target (`local`).
    local_target: ?bool = null,

    /// [IPv4 traffic only] The ID of a NAT gateway.
    nat_gateway_id: ?[]const u8 = null,

    /// The ID of a network interface.
    network_interface_id: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the ODB network.
    odb_network_arn: ?[]const u8 = null,

    /// The ID of the route table.
    route_table_id: []const u8,

    /// The ID of a transit gateway.
    transit_gateway_id: ?[]const u8 = null,

    /// The ID of a VPC endpoint. Supported for Gateway Load Balancer endpoints
    /// only.
    vpc_endpoint_id: ?[]const u8 = null,

    /// The ID of a VPC peering connection.
    vpc_peering_connection_id: ?[]const u8 = null,
};

const ReplaceRouteOutput = struct {};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ReplaceRouteInput, options: Options) !ReplaceRouteOutput {
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
            d.* = parseErrorResponse(response.body, response.status, client.allocator) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(response.body, response.status, response.headers, allocator);
    return result;
}

fn serializeRequest(alloc: std.mem.Allocator, input: ReplaceRouteInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("ec2", "EC2", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var body_buf: std.ArrayList(u8) = .{};

    try body_buf.appendSlice(alloc, "Action=ReplaceRoute&Version=2016-11-15");
    if (input.carrier_gateway_id) |v| {
        try body_buf.appendSlice(alloc, "&CarrierGatewayId=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.core_network_arn) |v| {
        try body_buf.appendSlice(alloc, "&CoreNetworkArn=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.destination_cidr_block) |v| {
        try body_buf.appendSlice(alloc, "&DestinationCidrBlock=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.destination_ipv_6_cidr_block) |v| {
        try body_buf.appendSlice(alloc, "&DestinationIpv6CidrBlock=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.destination_prefix_list_id) |v| {
        try body_buf.appendSlice(alloc, "&DestinationPrefixListId=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.dry_run) |v| {
        try body_buf.appendSlice(alloc, "&DryRun=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, if (v) "true" else "false");
    }
    if (input.egress_only_internet_gateway_id) |v| {
        try body_buf.appendSlice(alloc, "&EgressOnlyInternetGatewayId=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.gateway_id) |v| {
        try body_buf.appendSlice(alloc, "&GatewayId=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.instance_id) |v| {
        try body_buf.appendSlice(alloc, "&InstanceId=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.local_gateway_id) |v| {
        try body_buf.appendSlice(alloc, "&LocalGatewayId=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.local_target) |v| {
        try body_buf.appendSlice(alloc, "&LocalTarget=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, if (v) "true" else "false");
    }
    if (input.nat_gateway_id) |v| {
        try body_buf.appendSlice(alloc, "&NatGatewayId=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.network_interface_id) |v| {
        try body_buf.appendSlice(alloc, "&NetworkInterfaceId=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.odb_network_arn) |v| {
        try body_buf.appendSlice(alloc, "&OdbNetworkArn=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, v);
    }
    try body_buf.appendSlice(alloc, "&RouteTableId=");
    try aws.url.appendUrlEncoded(alloc, &body_buf, input.route_table_id);
    if (input.transit_gateway_id) |v| {
        try body_buf.appendSlice(alloc, "&TransitGatewayId=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.vpc_endpoint_id) |v| {
        try body_buf.appendSlice(alloc, "&VpcEndpointId=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.vpc_peering_connection_id) |v| {
        try body_buf.appendSlice(alloc, "&VpcPeeringConnectionId=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, v);
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

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !ReplaceRouteOutput {
    _ = status;
    _ = headers;
    _ = body;
    _ = alloc;
    const result: ReplaceRouteOutput = .{};

    return result;
}

fn parseErrorResponse(body: []const u8, status: u16, alloc: std.mem.Allocator) !ServiceError {
    const error_code = aws.xml.findElement(body, "Code") orelse "Unknown";
    const error_message = aws.xml.findElement(body, "Message") orelse "";
    const request_id = aws.xml.findElement(body, "RequestID") orelse "";
    var arena = std.heap.ArenaAllocator.init(alloc);
    errdefer arena.deinit();
    const arena_alloc = arena.allocator();
    const owned_message = try arena_alloc.dupe(u8, error_message);
    const owned_request_id = try arena_alloc.dupe(u8, request_id);


    const owned_code = try arena_alloc.dupe(u8, error_code);
    return .{ .arena = arena, .kind = .{ .unknown = .{
        .code = owned_code,
        .message = owned_message,
        .request_id = owned_request_id,
        .http_status = status,
    } } };
}
