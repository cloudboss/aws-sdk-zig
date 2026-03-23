const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const VpcCidrBlockAssociation = @import("vpc_cidr_block_association.zig").VpcCidrBlockAssociation;
const VpcIpv6CidrBlockAssociation = @import("vpc_ipv_6_cidr_block_association.zig").VpcIpv6CidrBlockAssociation;
const serde = @import("serde.zig");

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
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: AssociateVpcCidrBlockInput, options: CallOptions) !AssociateVpcCidrBlockOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "ec2");

    var response = try client.http_client.sendRequest(&request);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = parseErrorResponse(client.allocator, response.body, response.status) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: AssociateVpcCidrBlockInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("ec2", "EC2", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var body_buf: std.ArrayList(u8) = .{};

    try body_buf.appendSlice(allocator, "Action=AssociateVpcCidrBlock&Version=2016-11-15");
    if (input.amazon_provided_ipv_6_cidr_block) |v| {
        try body_buf.appendSlice(allocator, "&AmazonProvidedIpv6CidrBlock=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, if (v) "true" else "false");
    }
    if (input.cidr_block) |v| {
        try body_buf.appendSlice(allocator, "&CidrBlock=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.ipv_4_ipam_pool_id) |v| {
        try body_buf.appendSlice(allocator, "&Ipv4IpamPoolId=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.ipv_4_netmask_length) |v| {
        try body_buf.appendSlice(allocator, "&Ipv4NetmaskLength=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{v}) catch "");
    }
    if (input.ipv_6_cidr_block) |v| {
        try body_buf.appendSlice(allocator, "&Ipv6CidrBlock=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.ipv_6_cidr_block_network_border_group) |v| {
        try body_buf.appendSlice(allocator, "&Ipv6CidrBlockNetworkBorderGroup=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.ipv_6_ipam_pool_id) |v| {
        try body_buf.appendSlice(allocator, "&Ipv6IpamPoolId=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.ipv_6_netmask_length) |v| {
        try body_buf.appendSlice(allocator, "&Ipv6NetmaskLength=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{v}) catch "");
    }
    if (input.ipv_6_pool) |v| {
        try body_buf.appendSlice(allocator, "&Ipv6Pool=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    try body_buf.appendSlice(allocator, "&VpcId=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.vpc_id);

    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = "/";
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-www-form-urlencoded");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !AssociateVpcCidrBlockOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => break,
            else => {},
        }
    }

    var result: AssociateVpcCidrBlockOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "cidrBlockAssociation")) {
                    result.cidr_block_association = try serde.deserializeVpcCidrBlockAssociation(allocator, &reader);
                } else if (std.mem.eql(u8, e.local, "ipv6CidrBlockAssociation")) {
                    result.ipv_6_cidr_block_association = try serde.deserializeVpcIpv6CidrBlockAssociation(allocator, &reader);
                } else if (std.mem.eql(u8, e.local, "vpcId")) {
                    result.vpc_id = try allocator.dupe(u8, try reader.readElementText());
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

fn parseErrorResponse(allocator: std.mem.Allocator, body: []const u8, status: u16) !ServiceError {
    const error_code = aws.xml.findElement(body, "Code") orelse "Unknown";
    const error_message = aws.xml.findElement(body, "Message") orelse "";
    const request_id = aws.xml.findElement(body, "RequestID") orelse "";
    var arena = std.heap.ArenaAllocator.init(allocator);
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
