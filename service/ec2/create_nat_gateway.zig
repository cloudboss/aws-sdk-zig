const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const AvailabilityMode = @import("availability_mode.zig").AvailabilityMode;
const AvailabilityZoneAddress = @import("availability_zone_address.zig").AvailabilityZoneAddress;
const ConnectivityType = @import("connectivity_type.zig").ConnectivityType;
const TagSpecification = @import("tag_specification.zig").TagSpecification;
const NatGateway = @import("nat_gateway.zig").NatGateway;

/// Creates a NAT gateway in the specified subnet. This action creates a network
/// interface
/// in the specified subnet with a private IP address from the IP address range
/// of the
/// subnet. You can create either a public NAT gateway or a private NAT gateway.
///
/// With a public NAT gateway, internet-bound traffic from a private subnet can
/// be routed
/// to the NAT gateway, so that instances in a private subnet can connect to the
/// internet.
///
/// With a private NAT gateway, private communication is routed across VPCs and
/// on-premises
/// networks through a transit gateway or virtual private gateway. Common use
/// cases include
/// running large workloads behind a small pool of allowlisted IPv4 addresses,
/// preserving
/// private IPv4 addresses, and communicating between overlapping networks.
///
/// For more information, see [NAT
/// gateways](https://docs.aws.amazon.com/vpc/latest/userguide/vpc-nat-gateway.html) in the *Amazon VPC User Guide*.
///
/// **Important:**
///
/// When you create a public NAT gateway and assign it an EIP or secondary EIPs,
/// the network border group of the EIPs must match the network border group of
/// the Availability Zone (AZ)
/// that the public NAT gateway is in. If it's not the same, the NAT gateway
/// will fail to launch.
/// You can see the network border group for the subnet's AZ by viewing the
/// details of the subnet.
/// Similarly, you can view the network border group of an EIP by viewing the
/// details of the EIP address.
/// For more information about network border groups and EIPs, see [Allocate an
/// Elastic IP
/// address](https://docs.aws.amazon.com/vpc/latest/userguide/WorkWithEIPs.html)
/// in the *Amazon VPC User Guide*.
pub const CreateNatGatewayInput = struct {
    /// [Public NAT gateways only] The allocation ID of an Elastic IP address to
    /// associate
    /// with the NAT gateway. You cannot specify an Elastic IP address with a
    /// private NAT gateway.
    /// If the Elastic IP address is associated with another resource, you must
    /// first disassociate it.
    allocation_id: ?[]const u8 = null,

    /// Specifies whether to create a zonal (single-AZ) or regional (multi-AZ) NAT
    /// gateway. Defaults to `zonal`.
    ///
    /// A zonal NAT gateway is a NAT Gateway that provides redundancy and
    /// scalability within a single availability zone. A regional NAT gateway is a
    /// single NAT Gateway that works across multiple availability zones (AZs) in
    /// your VPC, providing redundancy, scalability and availability across all the
    /// AZs in a Region.
    ///
    /// For more information, see [Regional NAT gateways for automatic multi-AZ
    /// expansion](https://docs.aws.amazon.com/vpc/latest/userguide/nat-gateways-regional.html) in the *Amazon VPC User Guide*.
    availability_mode: ?AvailabilityMode = null,

    /// For regional NAT gateways only: Specifies which Availability Zones you want
    /// the NAT gateway to support and the Elastic IP addresses (EIPs) to use in
    /// each AZ. The regional NAT gateway uses these EIPs to handle outbound NAT
    /// traffic from their respective AZs. If not specified, the NAT gateway will
    /// automatically expand to new AZs and associate EIPs upon detection of an
    /// elastic network interface. If you specify this parameter, auto-expansion is
    /// disabled and you must manually manage AZ coverage.
    ///
    /// A regional NAT gateway is a single NAT Gateway that works across multiple
    /// availability zones (AZs) in your VPC, providing redundancy, scalability and
    /// availability across all the AZs in a Region.
    ///
    /// For more information, see [Regional NAT gateways for automatic multi-AZ
    /// expansion](https://docs.aws.amazon.com/vpc/latest/userguide/nat-gateways-regional.html) in the *Amazon VPC User Guide*.
    availability_zone_addresses: ?[]const AvailabilityZoneAddress = null,

    /// Unique, case-sensitive identifier that you provide to ensure the idempotency
    /// of the
    /// request. For more information, see [Ensuring
    /// idempotency](https://docs.aws.amazon.com/ec2/latest/devguide/ec2-api-idempotency.html).
    ///
    /// Constraint: Maximum 64 ASCII characters.
    client_token: ?[]const u8 = null,

    /// Indicates whether the NAT gateway supports public or private connectivity.
    /// The default is public connectivity.
    connectivity_type: ?ConnectivityType = null,

    /// Checks whether you have the required permissions for the action, without
    /// actually making the request,
    /// and provides an error response. If you have the required permissions, the
    /// error response is `DryRunOperation`.
    /// Otherwise, it is `UnauthorizedOperation`.
    dry_run: ?bool = null,

    /// The private IPv4 address to assign to the NAT gateway. If you don't provide
    /// an address, a private IPv4 address will be automatically assigned.
    private_ip_address: ?[]const u8 = null,

    /// Secondary EIP allocation IDs. For more information, see [Create a NAT
    /// gateway](https://docs.aws.amazon.com/vpc/latest/userguide/nat-gateway-working-with.html)
    /// in the *Amazon VPC User Guide*.
    secondary_allocation_ids: ?[]const []const u8 = null,

    /// [Private NAT gateway only] The number of secondary private IPv4 addresses
    /// you want to assign to the NAT gateway.
    /// For more information about secondary addresses, see [Create a NAT
    /// gateway](https://docs.aws.amazon.com/vpc/latest/userguide/nat-gateway-working-with.html)
    /// in the *Amazon VPC User Guide*.
    secondary_private_ip_address_count: ?i32 = null,

    /// Secondary private IPv4 addresses. For more information about secondary
    /// addresses, see
    /// [Create a NAT
    /// gateway](https://docs.aws.amazon.com/vpc/latest/userguide/nat-gateway-working-with.html) in the *Amazon VPC User Guide*.
    secondary_private_ip_addresses: ?[]const []const u8 = null,

    /// The ID of the subnet in which to create the NAT gateway.
    subnet_id: ?[]const u8 = null,

    /// The tags to assign to the NAT gateway.
    tag_specifications: ?[]const TagSpecification = null,

    /// The ID of the VPC where you want to create a regional NAT gateway.
    vpc_id: ?[]const u8 = null,
};

pub const CreateNatGatewayOutput = struct {
    /// Unique, case-sensitive identifier to ensure the idempotency of the request.
    /// Only returned if a client token was provided in the request.
    client_token: ?[]const u8 = null,

    /// Information about the NAT gateway.
    nat_gateway: ?NatGateway = null,

    allocator: std.mem.Allocator,

    pub fn deinit(self: *const CreateNatGatewayOutput) void {
        if (self.client_token) |v| {
            self.allocator.free(v);
        }
    }
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, input: CreateNatGatewayInput, options: Options) !CreateNatGatewayOutput {
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

    return try deserializeResponse(response.body, response.status, response.headers, client.allocator);
}

fn serializeRequest(alloc: std.mem.Allocator, input: CreateNatGatewayInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpoint("ec2", alloc);

    const host = parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = parsePort(endpoint);

    var body_buf: std.ArrayList(u8) = .{};

    try body_buf.appendSlice(alloc, "Action=CreateNatGateway&Version=2016-11-15");
    if (input.allocation_id) |v| {
        try body_buf.appendSlice(alloc, "&AllocationId=");
        try appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.availability_mode) |v| {
        try body_buf.appendSlice(alloc, "&AvailabilityMode=");
        try appendUrlEncoded(alloc, &body_buf, @tagName(v));
    }
    if (input.availability_zone_addresses) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&AvailabilityZoneAddresses.AvailabilityZoneAddress.{d}.AvailabilityZone=", .{n}) catch continue;
                try body_buf.appendSlice(alloc, field_prefix);
                if (item.availability_zone) |v| {
                    try appendUrlEncoded(alloc, &body_buf, v);
                }
            }
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&AvailabilityZoneAddresses.AvailabilityZoneAddress.{d}.AvailabilityZoneId=", .{n}) catch continue;
                try body_buf.appendSlice(alloc, field_prefix);
                if (item.availability_zone_id) |v| {
                    try appendUrlEncoded(alloc, &body_buf, v);
                }
            }
        }
    }
    if (input.client_token) |v| {
        try body_buf.appendSlice(alloc, "&ClientToken=");
        try appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.connectivity_type) |v| {
        try body_buf.appendSlice(alloc, "&ConnectivityType=");
        try appendUrlEncoded(alloc, &body_buf, @tagName(v));
    }
    if (input.dry_run) |v| {
        try body_buf.appendSlice(alloc, "&DryRun=");
        try appendUrlEncoded(alloc, &body_buf, if (v) "true" else "false");
    }
    if (input.private_ip_address) |v| {
        try body_buf.appendSlice(alloc, "&PrivateIpAddress=");
        try appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.secondary_allocation_ids) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            var prefix_buf: [256]u8 = undefined;
            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SecondaryAllocationIds.AllocationId.{d}=", .{n}) catch continue;
            try body_buf.appendSlice(alloc, field_prefix);
            try appendUrlEncoded(alloc, &body_buf, item);
        }
    }
    if (input.secondary_private_ip_address_count) |v| {
        try body_buf.appendSlice(alloc, "&SecondaryPrivateIpAddressCount=");
        try appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{v}) catch "");
    }
    if (input.secondary_private_ip_addresses) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            var prefix_buf: [256]u8 = undefined;
            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SecondaryPrivateIpAddresses.item.{d}=", .{n}) catch continue;
            try body_buf.appendSlice(alloc, field_prefix);
            try appendUrlEncoded(alloc, &body_buf, item);
        }
    }
    if (input.subnet_id) |v| {
        try body_buf.appendSlice(alloc, "&SubnetId=");
        try appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.tag_specifications) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&TagSpecifications.item.{d}.ResourceType=", .{n}) catch continue;
                try body_buf.appendSlice(alloc, field_prefix);
                if (item.resource_type) |v| {
                    try appendUrlEncoded(alloc, &body_buf, @tagName(v));
                }
            }
        }
    }
    if (input.vpc_id) |v| {
        try body_buf.appendSlice(alloc, "&VpcId=");
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

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !CreateNatGatewayOutput {
    _ = status;
    _ = headers;
    var result: CreateNatGatewayOutput = .{ .allocator = alloc };
    if (findElement(body, "clientToken")) |content| {
        result.client_token = try alloc.dupe(u8, content);
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
