const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const EnablePrefixForIpv6SourceNatEnum = @import("enable_prefix_for_ipv_6_source_nat_enum.zig").EnablePrefixForIpv6SourceNatEnum;
const IpAddressType = @import("ip_address_type.zig").IpAddressType;
const IpamPools = @import("ipam_pools.zig").IpamPools;
const LoadBalancerSchemeEnum = @import("load_balancer_scheme_enum.zig").LoadBalancerSchemeEnum;
const SubnetMapping = @import("subnet_mapping.zig").SubnetMapping;
const Tag = @import("tag.zig").Tag;
const LoadBalancerTypeEnum = @import("load_balancer_type_enum.zig").LoadBalancerTypeEnum;
const LoadBalancer = @import("load_balancer.zig").LoadBalancer;
const serde = @import("serde.zig");

pub const CreateLoadBalancerInput = struct {
    /// [Application Load Balancers on Outposts] The ID of the customer-owned
    /// address pool (CoIP
    /// pool).
    customer_owned_ipv_4_pool: ?[]const u8 = null,

    /// [Network Load Balancers with UDP listeners] Indicates whether to use an IPv6
    /// prefix
    /// from each subnet for source NAT. The IP address type must be `dualstack`.
    /// The default value is `off`.
    enable_prefix_for_ipv_6_source_nat: ?EnablePrefixForIpv6SourceNatEnum = null,

    /// The IP address type. Internal load balancers must use `ipv4`.
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

    /// [Application Load Balancers] The IPAM pools to use with the load balancer.
    ipam_pools: ?IpamPools = null,

    /// The name of the load balancer.
    ///
    /// This name must be unique per region per account, can have a maximum of 32
    /// characters, must
    /// contain only alphanumeric characters or hyphens, must not begin or end with
    /// a hyphen, and must
    /// not begin with "internal-".
    name: []const u8,

    /// The nodes of an Internet-facing load balancer have public IP addresses. The
    /// DNS name of an
    /// Internet-facing load balancer is publicly resolvable to the public IP
    /// addresses of the nodes.
    /// Therefore, Internet-facing load balancers can route requests from clients
    /// over the
    /// internet.
    ///
    /// The nodes of an internal load balancer have only private IP addresses. The
    /// DNS name of an
    /// internal load balancer is publicly resolvable to the private IP addresses of
    /// the nodes.
    /// Therefore, internal load balancers can route requests only from clients with
    /// access to the VPC
    /// for the load balancer.
    ///
    /// The default is an Internet-facing load balancer.
    ///
    /// You can't specify a scheme for a Gateway Load Balancer.
    scheme: ?LoadBalancerSchemeEnum = null,

    /// [Application Load Balancers and Network Load Balancers] The IDs of the
    /// security groups for
    /// the load balancer.
    security_groups: ?[]const []const u8 = null,

    /// The IDs of the subnets. You can specify only one subnet per Availability
    /// Zone. You
    /// must specify either subnets or subnet mappings, but not both.
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
    /// Availability Zones. You
    /// can't specify Elastic IP addresses for your subnets.
    subnet_mappings: ?[]const SubnetMapping = null,

    /// The IDs of the subnets. You can specify only one subnet per Availability
    /// Zone. You
    /// must specify either subnets or subnet mappings, but not both. To specify an
    /// Elastic IP
    /// address, specify subnet mappings instead of subnets.
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
    /// [Network Load Balancers and Gateway Load Balancers] You can specify subnets
    /// from one or more
    /// Availability Zones.
    subnets: ?[]const []const u8 = null,

    /// The tags to assign to the load balancer.
    tags: ?[]const Tag = null,

    /// The type of load balancer. The default is `application`.
    type: ?LoadBalancerTypeEnum = null,
};

pub const CreateLoadBalancerOutput = struct {
    /// Information about the load balancer.
    load_balancers: ?[]const LoadBalancer = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateLoadBalancerInput, options: CallOptions) !CreateLoadBalancerOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateLoadBalancerInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("elasticloadbalancing", "Elastic Load Balancing v2", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=CreateLoadBalancer&Version=2015-12-01");
    if (input.customer_owned_ipv_4_pool) |v| {
        try body_buf.appendSlice(allocator, "&CustomerOwnedIpv4Pool=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.enable_prefix_for_ipv_6_source_nat) |v| {
        try body_buf.appendSlice(allocator, "&EnablePrefixForIpv6SourceNat=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v.wireName());
    }
    if (input.ip_address_type) |v| {
        try body_buf.appendSlice(allocator, "&IpAddressType=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v.wireName());
    }
    if (input.ipam_pools) |v| {
        if (v.ipv_4_ipam_pool_id) |sv| {
            try body_buf.appendSlice(allocator, "&IpamPools.Ipv4IpamPoolId=");
            try aws.url.appendUrlEncoded(allocator, &body_buf, sv);
        }
    }
    try body_buf.appendSlice(allocator, "&Name=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.name);
    if (input.scheme) |v| {
        try body_buf.appendSlice(allocator, "&Scheme=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v.wireName());
    }
    if (input.security_groups) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            var prefix_buf: [256]u8 = undefined;
            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SecurityGroups.member.{d}=", .{n}) catch continue;
            try body_buf.appendSlice(allocator, field_prefix);
            try aws.url.appendUrlEncoded(allocator, &body_buf, item);
        }
    }
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
    if (input.tags) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Tags.member.{d}.Key=", .{n}) catch continue;
                try body_buf.appendSlice(allocator, field_prefix);
                try aws.url.appendUrlEncoded(allocator, &body_buf, item.key);
            }
            {
                var prefix_buf: [256]u8 = undefined;
                if (item.value) |fv_1| {
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Tags.member.{d}.Value=", .{n}) catch continue;
                    try body_buf.appendSlice(allocator, field_prefix);
                    try aws.url.appendUrlEncoded(allocator, &body_buf, fv_1);
                }
            }
        }
    }
    if (input.type) |v| {
        try body_buf.appendSlice(allocator, "&Type=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v.wireName());
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateLoadBalancerOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "CreateLoadBalancerResult")) break;
            },
            else => {},
        }
    }

    var result: CreateLoadBalancerOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "LoadBalancers")) {
                    result.load_balancers = try serde.deserializeLoadBalancers(allocator, &reader, "member");
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
