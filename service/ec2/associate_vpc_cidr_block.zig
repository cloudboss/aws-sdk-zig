const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const VpcCidrBlockAssociation = @import("vpc_cidr_block_association.zig").VpcCidrBlockAssociation;
const VpcIpv6CidrBlockAssociation = @import("vpc_ipv_6_cidr_block_association.zig").VpcIpv6CidrBlockAssociation;

/// Associates a CIDR block with your VPC. You can associate a secondary IPv4
/// CIDR block,
/// an Amazon-provided IPv6 CIDR block, or an IPv6 CIDR block from an IPv6
/// address pool that
/// you provisioned through bring your own IP addresses
/// ([BYOIP](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ec2-byoip.html)).
///
/// You must specify one of the following in the request: an IPv4 CIDR block, an
/// IPv6
/// pool, or an Amazon-provided IPv6 CIDR block.
///
/// For more information about associating CIDR blocks with your VPC and
/// applicable
/// restrictions, see [IP addressing for your VPCs and
/// subnets](https://docs.aws.amazon.com/vpc/latest/userguide/vpc-ip-addressing.html)
/// in the *Amazon VPC User Guide*.
pub const AssociateVpcCidrBlockInput = struct {
    /// Requests an Amazon-provided IPv6 CIDR block with a /56 prefix length for the
    /// VPC. You
    /// cannot specify the range of IPv6 addresses or the size of the CIDR block.
    amazon_provided_ipv_6_cidr_block: ?bool = null,

    /// An IPv4 CIDR block to associate with the VPC.
    cidr_block: ?[]const u8 = null,

    /// Associate a CIDR allocated from an IPv4 IPAM pool to a VPC. For more
    /// information about Amazon VPC IP Address Manager (IPAM), see [What is
    /// IPAM?](https://docs.aws.amazon.com/vpc/latest/ipam/what-is-it-ipam.html) in
    /// the *Amazon VPC IPAM User Guide*.
    ipv_4_ipam_pool_id: ?[]const u8 = null,

    /// The netmask length of the IPv4 CIDR you would like to associate from an
    /// Amazon VPC IP Address Manager (IPAM) pool. For more information about IPAM,
    /// see [What is
    /// IPAM?](https://docs.aws.amazon.com/vpc/latest/ipam/what-is-it-ipam.html) in
    /// the *Amazon VPC IPAM User Guide*.
    ipv_4_netmask_length: ?i32 = null,

    /// An IPv6 CIDR block from the IPv6 address pool. You must also specify
    /// `Ipv6Pool` in the request.
    ///
    /// To let Amazon choose the IPv6 CIDR block for you, omit this parameter.
    ipv_6_cidr_block: ?[]const u8 = null,

    /// The name of the location from which we advertise the IPV6 CIDR block. Use
    /// this parameter
    /// to limit the CIDR block to this location.
    ///
    /// You must set `AmazonProvidedIpv6CidrBlock` to `true` to use this parameter.
    ///
    /// You can have one IPv6 CIDR block association per network border group.
    ipv_6_cidr_block_network_border_group: ?[]const u8 = null,

    /// Associates a CIDR allocated from an IPv6 IPAM pool to a VPC. For more
    /// information about Amazon VPC IP Address Manager (IPAM), see [What is
    /// IPAM?](https://docs.aws.amazon.com/vpc/latest/ipam/what-is-it-ipam.html) in
    /// the *Amazon VPC IPAM User Guide*.
    ipv_6_ipam_pool_id: ?[]const u8 = null,

    /// The netmask length of the IPv6 CIDR you would like to associate from an
    /// Amazon VPC IP Address Manager (IPAM) pool. For more information about IPAM,
    /// see [What is
    /// IPAM?](https://docs.aws.amazon.com/vpc/latest/ipam/what-is-it-ipam.html) in
    /// the *Amazon VPC IPAM User Guide*.
    ipv_6_netmask_length: ?i32 = null,

    /// The ID of an IPv6 address pool from which to allocate the IPv6 CIDR block.
    ipv_6_pool: ?[]const u8 = null,

    /// The ID of the VPC.
    vpc_id: []const u8,
};

pub const AssociateVpcCidrBlockOutput = struct {
    /// Information about the IPv4 CIDR block association.
    cidr_block_association: ?VpcCidrBlockAssociation = null,

    /// Information about the IPv6 CIDR block association.
    ipv_6_cidr_block_association: ?VpcIpv6CidrBlockAssociation = null,

    /// The ID of the VPC.
    vpc_id: ?[]const u8 = null,

    allocator: std.mem.Allocator,

    pub fn deinit(self: *const AssociateVpcCidrBlockOutput) void {
        if (self.vpc_id) |v| {
            self.allocator.free(v);
        }
    }
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, input: AssociateVpcCidrBlockInput, options: Options) !AssociateVpcCidrBlockOutput {
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

fn serializeRequest(alloc: std.mem.Allocator, input: AssociateVpcCidrBlockInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpoint("ec2", alloc);

    const host = parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = parsePort(endpoint);

    var body_buf: std.ArrayList(u8) = .{};

    try body_buf.appendSlice(alloc, "Action=AssociateVpcCidrBlock&Version=2016-11-15");
    if (input.amazon_provided_ipv_6_cidr_block) |v| {
        try body_buf.appendSlice(alloc, "&AmazonProvidedIpv6CidrBlock=");
        try appendUrlEncoded(alloc, &body_buf, if (v) "true" else "false");
    }
    if (input.cidr_block) |v| {
        try body_buf.appendSlice(alloc, "&CidrBlock=");
        try appendUrlEncoded(alloc, &body_buf, v);
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
    if (input.ipv_6_cidr_block_network_border_group) |v| {
        try body_buf.appendSlice(alloc, "&Ipv6CidrBlockNetworkBorderGroup=");
        try appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.ipv_6_ipam_pool_id) |v| {
        try body_buf.appendSlice(alloc, "&Ipv6IpamPoolId=");
        try appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.ipv_6_netmask_length) |v| {
        try body_buf.appendSlice(alloc, "&Ipv6NetmaskLength=");
        try appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{v}) catch "");
    }
    if (input.ipv_6_pool) |v| {
        try body_buf.appendSlice(alloc, "&Ipv6Pool=");
        try appendUrlEncoded(alloc, &body_buf, v);
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

fn deserializeResponse(body: []const u8, status: u16, alloc: std.mem.Allocator) !AssociateVpcCidrBlockOutput {
    _ = status;
    var result: AssociateVpcCidrBlockOutput = .{ .allocator = alloc };
    if (findElement(body, "vpcId")) |content| {
        result.vpc_id = try alloc.dupe(u8, content);
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
