const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const TagSpecification = @import("tag_specification.zig").TagSpecification;
const Subnet = @import("subnet.zig").Subnet;

/// Creates a subnet in the specified VPC. For an IPv4 only subnet, specify an
/// IPv4 CIDR block.
/// If the VPC has an IPv6 CIDR block, you can create an IPv6 only subnet or a
/// dual stack subnet instead.
/// For an IPv6 only subnet, specify an IPv6 CIDR block. For a dual stack
/// subnet, specify both
/// an IPv4 CIDR block and an IPv6 CIDR block.
///
/// A subnet CIDR block must not overlap the CIDR block of an existing subnet in
/// the VPC.
/// After you create a subnet, you can't change its CIDR block.
///
/// The allowed size for an IPv4 subnet is between a /28 netmask (16 IP
/// addresses) and
/// a /16 netmask (65,536 IP addresses). Amazon Web Services reserves both the
/// first four and
/// the last IPv4 address in each subnet's CIDR block. They're not available for
/// your use.
///
/// If you've associated an IPv6 CIDR block with your VPC, you can associate an
/// IPv6 CIDR
/// block with a subnet when you create it.
///
/// If you add more than one subnet to a VPC, they're set up in a star topology
/// with a
/// logical router in the middle.
///
/// When you stop an instance in a subnet, it retains its private IPv4 address.
/// It's
/// therefore possible to have a subnet with no running instances (they're all
/// stopped), but
/// no remaining IP addresses available.
///
/// For more information, see
/// [Subnets](https://docs.aws.amazon.com/vpc/latest/userguide/configure-subnets.html) in the *Amazon VPC User Guide*.
pub const CreateSubnetInput = struct {
    /// The Availability Zone or Local Zone for the subnet.
    ///
    /// Default: Amazon Web Services selects one for you. If you create more than
    /// one subnet in your VPC, we
    /// do not necessarily select a different zone for each subnet.
    ///
    /// To create a subnet in a Local Zone, set this value to the Local Zone ID, for
    /// example
    /// `us-west-2-lax-1a`. For information about the Regions that support Local
    /// Zones,
    /// see [Available Local
    /// Zones](https://docs.aws.amazon.com/local-zones/latest/ug/available-local-zones.html).
    ///
    /// To create a subnet in an Outpost, set this value to the Availability Zone
    /// for the
    /// Outpost and specify the Outpost ARN.
    availability_zone: ?[]const u8 = null,

    /// The AZ ID or the Local Zone ID of the subnet.
    availability_zone_id: ?[]const u8 = null,

    /// The IPv4 network range for the subnet, in CIDR notation. For example,
    /// `10.0.0.0/24`.
    /// We modify the specified CIDR block to its canonical form; for example, if
    /// you specify
    /// `100.68.0.18/18`, we modify it to `100.68.0.0/18`.
    ///
    /// This parameter is not supported for an IPv6 only subnet.
    cidr_block: ?[]const u8 = null,

    /// Checks whether you have the required permissions for the action, without
    /// actually making the request,
    /// and provides an error response. If you have the required permissions, the
    /// error response is `DryRunOperation`.
    /// Otherwise, it is `UnauthorizedOperation`.
    dry_run: ?bool = null,

    /// An IPv4 IPAM pool ID for the subnet.
    ipv_4_ipam_pool_id: ?[]const u8 = null,

    /// An IPv4 netmask length for the subnet.
    ipv_4_netmask_length: ?i32 = null,

    /// The IPv6 network range for the subnet, in CIDR notation. This parameter is
    /// required
    /// for an IPv6 only subnet.
    ipv_6_cidr_block: ?[]const u8 = null,

    /// An IPv6 IPAM pool ID for the subnet.
    ipv_6_ipam_pool_id: ?[]const u8 = null,

    /// Indicates whether to create an IPv6 only subnet.
    ipv_6_native: ?bool = null,

    /// An IPv6 netmask length for the subnet.
    ipv_6_netmask_length: ?i32 = null,

    /// The Amazon Resource Name (ARN) of the Outpost. If you specify an Outpost
    /// ARN, you must also
    /// specify the Availability Zone of the Outpost subnet.
    outpost_arn: ?[]const u8 = null,

    /// The tags to assign to the subnet.
    tag_specifications: ?[]const TagSpecification = null,

    /// The ID of the VPC.
    vpc_id: []const u8,
};

pub const CreateSubnetOutput = struct {
    /// Information about the subnet.
    subnet: ?Subnet = null,

    allocator: std.mem.Allocator,

    pub fn deinit(self: *const CreateSubnetOutput) void {
        _ = self;
    }
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, input: CreateSubnetInput, options: Options) !CreateSubnetOutput {
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

fn serializeRequest(alloc: std.mem.Allocator, input: CreateSubnetInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpoint("ec2", alloc);

    const host = parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = parsePort(endpoint);

    var body_buf: std.ArrayList(u8) = .{};

    try body_buf.appendSlice(alloc, "Action=CreateSubnet&Version=2016-11-15");
    if (input.availability_zone) |v| {
        try body_buf.appendSlice(alloc, "&AvailabilityZone=");
        try appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.availability_zone_id) |v| {
        try body_buf.appendSlice(alloc, "&AvailabilityZoneId=");
        try appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.cidr_block) |v| {
        try body_buf.appendSlice(alloc, "&CidrBlock=");
        try appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.dry_run) |v| {
        try body_buf.appendSlice(alloc, "&DryRun=");
        try appendUrlEncoded(alloc, &body_buf, if (v) "true" else "false");
    }
    if (input.ipv_4_ipam_pool_id) |v| {
        try body_buf.appendSlice(alloc, "&Ipv4IpamPoolId=");
        try appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.ipv_4_netmask_length) |v| {
        try body_buf.appendSlice(alloc, "&Ipv4NetmaskLength=");
        try appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{v}) catch "");
    }
    if (input.ipv_6_cidr_block) |v| {
        try body_buf.appendSlice(alloc, "&Ipv6CidrBlock=");
        try appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.ipv_6_ipam_pool_id) |v| {
        try body_buf.appendSlice(alloc, "&Ipv6IpamPoolId=");
        try appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.ipv_6_native) |v| {
        try body_buf.appendSlice(alloc, "&Ipv6Native=");
        try appendUrlEncoded(alloc, &body_buf, if (v) "true" else "false");
    }
    if (input.ipv_6_netmask_length) |v| {
        try body_buf.appendSlice(alloc, "&Ipv6NetmaskLength=");
        try appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{v}) catch "");
    }
    if (input.outpost_arn) |v| {
        try body_buf.appendSlice(alloc, "&OutpostArn=");
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
    try body_buf.appendSlice(alloc, "&VpcId=");
    try appendUrlEncoded(alloc, &body_buf, input.vpc_id);

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

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !CreateSubnetOutput {
    _ = status;
    _ = headers;
    _ = body;
    const result: CreateSubnetOutput = .{ .allocator = alloc };

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
