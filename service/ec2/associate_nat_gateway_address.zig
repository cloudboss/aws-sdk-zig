const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const NatGatewayAddress = @import("nat_gateway_address.zig").NatGatewayAddress;
const serde = @import("serde.zig");

/// Associates Elastic IP addresses (EIPs) and private IPv4 addresses with a
/// public NAT gateway. For more information,
/// see [Work with NAT
/// gateways](https://docs.aws.amazon.com/vpc/latest/userguide/nat-gateway-working-with.html) in the *Amazon VPC User Guide*.
///
/// By default, you can associate up to 2 Elastic IP addresses per public NAT
/// gateway. You can increase the limit by requesting a quota adjustment.
/// For more information, see [Elastic IP address
/// quotas](https://docs.aws.amazon.com/vpc/latest/userguide/amazon-vpc-limits.html#vpc-limits-eips) in the *Amazon VPC User Guide*.
///
/// **Important:**
///
/// When you associate an EIP or secondary EIPs with a public NAT gateway, the
/// network border group of the EIPs
/// must match the network border group of the Availability Zone (AZ) that the
/// public NAT gateway is in. If it's not the same,
/// the EIP will fail to associate. You can see the network border group for the
/// subnet's AZ by viewing the details of the subnet.
/// Similarly, you can view the network border group of an EIP by viewing the
/// details of the EIP address. For more information
/// about network border groups and EIPs, see [Allocate an Elastic IP
/// address](https://docs.aws.amazon.com/vpc/latest/userguide/WorkWithEIPs.html)
/// in the *Amazon VPC User Guide*.
pub const AssociateNatGatewayAddressInput = struct {
    /// The allocation IDs of EIPs that you want to associate with your NAT gateway.
    allocation_ids: []const []const u8,

    /// For regional NAT gateways only: The Availability Zone where you want to
    /// associate an Elastic IP address (EIP). The regional NAT gateway uses a
    /// separate EIP in each AZ to handle outbound NAT traffic from that AZ.
    ///
    /// A regional NAT gateway is a single NAT Gateway that works across multiple
    /// availability zones (AZs) in your VPC, providing redundancy, scalability and
    /// availability across all the AZs in a Region.
    availability_zone: ?[]const u8 = null,

    /// For regional NAT gateways only: The ID of the Availability Zone where you
    /// want to associate an Elastic IP address (EIP). The regional NAT gateway uses
    /// a separate EIP in each AZ to handle outbound NAT traffic from that AZ. Use
    /// this instead of AvailabilityZone for consistent identification of AZs across
    /// Amazon Web Services Regions.
    ///
    /// A regional NAT gateway is a single NAT Gateway that works across multiple
    /// availability zones (AZs) in your VPC, providing redundancy, scalability and
    /// availability across all the AZs in a Region.
    availability_zone_id: ?[]const u8 = null,

    /// Checks whether you have the required permissions for the action, without
    /// actually making the request,
    /// and provides an error response. If you have the required permissions, the
    /// error response is `DryRunOperation`.
    /// Otherwise, it is `UnauthorizedOperation`.
    dry_run: ?bool = null,

    /// The ID of the NAT gateway.
    nat_gateway_id: []const u8,

    /// The private IPv4 addresses that you want to assign to the NAT gateway.
    private_ip_addresses: ?[]const []const u8 = null,
};

pub const AssociateNatGatewayAddressOutput = struct {
    /// The IP addresses.
    nat_gateway_addresses: ?[]const NatGatewayAddress = null,

    /// The ID of the NAT gateway.
    nat_gateway_id: ?[]const u8 = null,

    _arena: std.heap.ArenaAllocator = undefined,

    pub fn deinit(self: *AssociateNatGatewayAddressOutput) void {
        self._arena.deinit();
    }
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, input: AssociateNatGatewayAddressInput, options: Options) !AssociateNatGatewayAddressOutput {
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

    var resp_arena = std.heap.ArenaAllocator.init(client.allocator);
    errdefer resp_arena.deinit();
    var result = try deserializeResponse(response.body, response.status, response.headers, resp_arena.allocator());
    result._arena = resp_arena;
    return result;
}

fn serializeRequest(alloc: std.mem.Allocator, input: AssociateNatGatewayAddressInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpoint("ec2", alloc);

    const host = parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = parsePort(endpoint);

    var body_buf: std.ArrayList(u8) = .{};

    try body_buf.appendSlice(alloc, "Action=AssociateNatGatewayAddress&Version=2016-11-15");
    for (input.allocation_ids, 0..) |item, idx| {
        const n = idx + 1;
        var prefix_buf: [256]u8 = undefined;
        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&AllocationIds.AllocationId.{d}=", .{n}) catch continue;
        try body_buf.appendSlice(alloc, field_prefix);
        try appendUrlEncoded(alloc, &body_buf, item);
    }
    if (input.availability_zone) |v| {
        try body_buf.appendSlice(alloc, "&AvailabilityZone=");
        try appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.availability_zone_id) |v| {
        try body_buf.appendSlice(alloc, "&AvailabilityZoneId=");
        try appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.dry_run) |v| {
        try body_buf.appendSlice(alloc, "&DryRun=");
        try appendUrlEncoded(alloc, &body_buf, if (v) "true" else "false");
    }
    try body_buf.appendSlice(alloc, "&NatGatewayId=");
    try appendUrlEncoded(alloc, &body_buf, input.nat_gateway_id);
    if (input.private_ip_addresses) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            var prefix_buf: [256]u8 = undefined;
            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&PrivateIpAddresses.item.{d}=", .{n}) catch continue;
            try body_buf.appendSlice(alloc, field_prefix);
            try appendUrlEncoded(alloc, &body_buf, item);
        }
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

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !AssociateNatGatewayAddressOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => break,
            else => {},
        }
    }

    var result: AssociateNatGatewayAddressOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "natGatewayAddressSet")) {
                    result.nat_gateway_addresses = try serde.deserializeNatGatewayAddressList(&reader, alloc, "item");
                } else if (std.mem.eql(u8, e.local, "natGatewayId")) {
                    result.nat_gateway_id = try alloc.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
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
