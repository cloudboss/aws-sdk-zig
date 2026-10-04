const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const EnablePrefixForIpv6SourceNatEnum = @import("enable_prefix_for_ipv_6_source_nat_enum.zig").EnablePrefixForIpv6SourceNatEnum;
const IpAddressType = @import("ip_address_type.zig").IpAddressType;
const SubnetMapping = @import("subnet_mapping.zig").SubnetMapping;
const AvailabilityZone = @import("availability_zone.zig").AvailabilityZone;
const serde = @import("serde.zig");

pub const SetSubnetsInput = struct {
    /// [Network Load Balancers with UDP listeners] Indicates whether to use an IPv6
    /// prefix
    /// from each subnet for source NAT. The IP address type must be `dualstack`.
    /// The default value is `off`.
    enable_prefix_for_ipv_6_source_nat: ?EnablePrefixForIpv6SourceNatEnum = null,

    /// The IP address type.
    ///
    /// [Application Load Balancers] The possible values are `ipv4` (IPv4
    /// addresses),
    /// `dualstack` (IPv4 and IPv6 addresses), and `dualstack-without-public-ipv4`
    /// (public IPv6 addresses and private IPv4 and IPv6 addresses).
    ///
    /// [Network Load Balancers and Gateway Load Balancers] The possible values are
    /// `ipv4`
    /// (IPv4 addresses) and `dualstack` (IPv4 and IPv6 addresses).
    ip_address_type: ?IpAddressType = null,

    /// The Amazon Resource Name (ARN) of the load balancer.
    load_balancer_arn: []const u8,

    /// The IDs of the public subnets. You can specify only one subnet per
    /// Availability Zone. You
    /// must specify either subnets or subnet mappings.
    ///
    /// [Application Load Balancers] You must specify subnets from at least two
    /// Availability
    /// Zones. You can't specify Elastic IP addresses for your subnets.
    ///
    /// [Application Load Balancers on Outposts] You must specify one Outpost
    /// subnet.
    ///
    /// [Application Load Balancers on Local Zones] You can specify subnets from one
    /// or more Local
    /// Zones.
    ///
    /// [Network Load Balancers] You can specify subnets from one or more
    /// Availability Zones. You
    /// can specify one Elastic IP address per subnet if you need static IP
    /// addresses for your
    /// internet-facing load balancer. For internal load balancers, you can specify
    /// one private IP
    /// address per subnet from the IPv4 range of the subnet. For internet-facing
    /// load balancer, you
    /// can specify one IPv6 address per subnet.
    ///
    /// [Gateway Load Balancers] You can specify subnets from one or more
    /// Availability
    /// Zones.
    subnet_mappings: ?[]const SubnetMapping = null,

    /// The IDs of the public subnets. You can specify only one subnet per
    /// Availability Zone. You
    /// must specify either subnets or subnet mappings.
    ///
    /// [Application Load Balancers] You must specify subnets from at least two
    /// Availability
    /// Zones.
    ///
    /// [Application Load Balancers on Outposts] You must specify one Outpost
    /// subnet.
    ///
    /// [Application Load Balancers on Local Zones] You can specify subnets from one
    /// or more Local
    /// Zones.
    ///
    /// [Network Load Balancers] You can specify subnets from one or more
    /// Availability Zones.
    ///
    /// [Gateway Load Balancers] You can specify subnets from one or more
    /// Availability Zones.
    /// You must include all subnets that were enabled previously, with their
    /// existing configurations,
    /// plus any additional subnets.
    subnets: ?[]const []const u8 = null,
};

pub const SetSubnetsOutput = struct {
    /// Information about the subnets.
    availability_zones: ?[]const AvailabilityZone = null,

    /// [Network Load Balancers] Indicates whether to use an IPv6 prefix from each
    /// subnet for source NAT.
    enable_prefix_for_ipv_6_source_nat: ?EnablePrefixForIpv6SourceNatEnum = null,

    /// The IP address type.
    ip_address_type: ?IpAddressType = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: SetSubnetsInput, options: CallOptions) !SetSubnetsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "elasticloadbalancing", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: SetSubnetsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("elasticloadbalancing", "Elastic Load Balancing v2", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=SetSubnets&Version=2015-12-01");
    if (input.enable_prefix_for_ipv_6_source_nat) |v| {
        try body_buf.appendSlice(allocator, "&EnablePrefixForIpv6SourceNat=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v.wireName());
    }
    if (input.ip_address_type) |v| {
        try body_buf.appendSlice(allocator, "&IpAddressType=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v.wireName());
    }
    try body_buf.appendSlice(allocator, "&LoadBalancerArn=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.load_balancer_arn);
    if (input.subnet_mappings) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            {
                var prefix_buf: [256]u8 = undefined;
                if (item.allocation_id) |fv_1| {
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SubnetMappings.member.{d}.AllocationId=", .{n}) catch continue;
                    try body_buf.appendSlice(allocator, field_prefix);
                    try aws.url.appendUrlEncoded(allocator, &body_buf, fv_1);
                }
            }
            {
                var prefix_buf: [256]u8 = undefined;
                if (item.i_pv_6_address) |fv_1| {
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SubnetMappings.member.{d}.IPv6Address=", .{n}) catch continue;
                    try body_buf.appendSlice(allocator, field_prefix);
                    try aws.url.appendUrlEncoded(allocator, &body_buf, fv_1);
                }
            }
            {
                var prefix_buf: [256]u8 = undefined;
                if (item.private_i_pv_4_address) |fv_1| {
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SubnetMappings.member.{d}.PrivateIPv4Address=", .{n}) catch continue;
                    try body_buf.appendSlice(allocator, field_prefix);
                    try aws.url.appendUrlEncoded(allocator, &body_buf, fv_1);
                }
            }
            {
                var prefix_buf: [256]u8 = undefined;
                if (item.source_nat_ipv_6_prefix) |fv_1| {
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SubnetMappings.member.{d}.SourceNatIpv6Prefix=", .{n}) catch continue;
                    try body_buf.appendSlice(allocator, field_prefix);
                    try aws.url.appendUrlEncoded(allocator, &body_buf, fv_1);
                }
            }
            {
                var prefix_buf: [256]u8 = undefined;
                if (item.subnet_id) |fv_1| {
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SubnetMappings.member.{d}.SubnetId=", .{n}) catch continue;
                    try body_buf.appendSlice(allocator, field_prefix);
                    try aws.url.appendUrlEncoded(allocator, &body_buf, fv_1);
                }
            }
        }
    }
    if (input.subnets) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            var prefix_buf: [256]u8 = undefined;
            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Subnets.member.{d}=", .{n}) catch continue;
            try body_buf.appendSlice(allocator, field_prefix);
            try aws.url.appendUrlEncoded(allocator, &body_buf, item);
        }
    }

    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-www-form-urlencoded");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !SetSubnetsOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "SetSubnetsResult")) break;
            },
            else => {},
        }
    }

    var result: SetSubnetsOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "AvailabilityZones")) {
                    result.availability_zones = try serde.deserializeAvailabilityZones(allocator, &reader, "member");
                } else if (std.mem.eql(u8, e.local, "EnablePrefixForIpv6SourceNat")) {
                    result.enable_prefix_for_ipv_6_source_nat = EnablePrefixForIpv6SourceNatEnum.fromWireName(try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "IpAddressType")) {
                    result.ip_address_type = IpAddressType.fromWireName(try reader.readElementText());
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
