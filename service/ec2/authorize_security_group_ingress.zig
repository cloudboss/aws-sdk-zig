const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const IpPermission = @import("ip_permission.zig").IpPermission;
const TagSpecification = @import("tag_specification.zig").TagSpecification;
const SecurityGroupRule = @import("security_group_rule.zig").SecurityGroupRule;
const serde = @import("serde.zig");

/// Adds the specified inbound (ingress) rules to a security group.
///
/// An inbound rule permits instances to receive traffic from the specified IPv4
/// or IPv6
/// address range, the IP address ranges that are specified by a prefix list, or
/// the instances
/// that are associated with a destination security group. For more information,
/// see [Security group
/// rules](https://docs.aws.amazon.com/vpc/latest/userguide/security-group-rules.html).
///
/// You must specify exactly one of the following sources: an IPv4 or IPv6
/// address range,
/// a prefix list, or a security group. You must specify a protocol for each
/// rule (for example, TCP).
/// If the protocol is TCP or UDP, you must also specify a port or port range.
/// If the protocol is
/// ICMP or ICMPv6, you must also specify the ICMP/ICMPv6 type and code.
///
/// Rule changes are propagated to instances associated with the security group
/// as quickly
/// as possible. However, a small delay might occur.
///
/// For examples of rules that you can add to security groups for specific
/// access scenarios,
/// see [Security group rules for different use
/// cases](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/security-group-rules-reference.html) in the *Amazon EC2 User Guide*.
///
/// For more information about security group quotas, see [Amazon VPC
/// quotas](https://docs.aws.amazon.com/vpc/latest/userguide/amazon-vpc-limits.html) in the *Amazon VPC User Guide*.
pub const AuthorizeSecurityGroupIngressInput = struct {
    /// The IPv4 address range, in CIDR format.
    ///
    /// **Note:**
    ///
    /// Amazon Web Services
    /// [canonicalizes](https://en.wikipedia.org/wiki/Canonicalization) IPv4 and
    /// IPv6 CIDRs. For example, if you specify 100.68.0.18/18 for the CIDR block,
    /// Amazon Web Services canonicalizes the CIDR block to 100.68.0.0/18. Any
    /// subsequent DescribeSecurityGroups and DescribeSecurityGroupRules calls will
    /// return the canonicalized form of the CIDR block. Additionally, if you
    /// attempt to add another rule with the
    /// non-canonical form of the CIDR (such as 100.68.0.18/18) and there is already
    /// a rule for the canonicalized
    /// form of the CIDR block (such as 100.68.0.0/18), the API throws an duplicate
    /// rule error.
    ///
    /// To specify an IPv6 address range, use IP permissions instead.
    ///
    /// To specify multiple rules and descriptions for the rules, use IP permissions
    /// instead.
    cidr_ip: ?[]const u8 = null,

    /// Checks whether you have the required permissions for the action, without
    /// actually making the request,
    /// and provides an error response. If you have the required permissions, the
    /// error response is `DryRunOperation`.
    /// Otherwise, it is `UnauthorizedOperation`.
    dry_run: ?bool = null,

    /// If the protocol is TCP or UDP, this is the start of the port range.
    /// If the protocol is ICMP, this is the ICMP type or -1 (all ICMP types).
    ///
    /// To specify multiple rules and descriptions for the rules, use IP permissions
    /// instead.
    from_port: ?i32 = null,

    /// The ID of the security group.
    group_id: ?[]const u8 = null,

    /// [Default VPC] The name of the security group. For security groups for a
    /// default VPC
    /// you can specify either the ID or the name of the security group. For
    /// security groups for
    /// a nondefault VPC, you must specify the ID of the security group.
    group_name: ?[]const u8 = null,

    /// The permissions for the security group rules.
    ip_permissions: ?[]const IpPermission = null,

    /// The IP protocol name (`tcp`, `udp`, `icmp`) or number
    /// (see [Protocol
    /// Numbers](http://www.iana.org/assignments/protocol-numbers/protocol-numbers.xhtml)). To specify all protocols, use `-1`.
    ///
    /// To specify `icmpv6`, use IP permissions instead.
    ///
    /// If you specify a protocol other than one of the supported values, traffic is
    /// allowed
    /// on all ports, regardless of any ports that you specify.
    ///
    /// To specify multiple rules and descriptions for the rules, use IP permissions
    /// instead.
    ip_protocol: ?[]const u8 = null,

    /// [Default VPC] The name of the source security group.
    ///
    /// The rule grants full ICMP, UDP, and TCP access. To create a rule with a
    /// specific protocol
    /// and port range, specify a set of IP permissions instead.
    source_security_group_name: ?[]const u8 = null,

    /// The Amazon Web Services account ID for the source security group, if the
    /// source security group is
    /// in a different account.
    ///
    /// The rule grants full ICMP, UDP, and TCP access. To create a rule with a
    /// specific protocol
    /// and port range, use IP permissions instead.
    source_security_group_owner_id: ?[]const u8 = null,

    /// The tags applied to the security group rule.
    tag_specifications: ?[]const TagSpecification = null,

    /// If the protocol is TCP or UDP, this is the end of the port range.
    /// If the protocol is ICMP, this is the ICMP code or -1 (all ICMP codes).
    /// If the start port is -1 (all ICMP types), then the end port must be -1 (all
    /// ICMP codes).
    ///
    /// To specify multiple rules and descriptions for the rules, use IP permissions
    /// instead.
    to_port: ?i32 = null,
};

pub const AuthorizeSecurityGroupIngressOutput = struct {
    /// Returns `true` if the request succeeds; otherwise, returns an error.
    @"return": ?bool = null,

    /// Information about the inbound (ingress) security group rules that were
    /// added.
    security_group_rules: ?[]const SecurityGroupRule = null,

    _arena: std.heap.ArenaAllocator = undefined,

    pub fn deinit(self: *AuthorizeSecurityGroupIngressOutput) void {
        self._arena.deinit();
    }
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, input: AuthorizeSecurityGroupIngressInput, options: Options) !AuthorizeSecurityGroupIngressOutput {
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

fn serializeRequest(alloc: std.mem.Allocator, input: AuthorizeSecurityGroupIngressInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpoint("ec2", alloc);

    const host = parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = parsePort(endpoint);

    var body_buf: std.ArrayList(u8) = .{};

    try body_buf.appendSlice(alloc, "Action=AuthorizeSecurityGroupIngress&Version=2016-11-15");
    if (input.cidr_ip) |v| {
        try body_buf.appendSlice(alloc, "&CidrIp=");
        try appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.dry_run) |v| {
        try body_buf.appendSlice(alloc, "&DryRun=");
        try appendUrlEncoded(alloc, &body_buf, if (v) "true" else "false");
    }
    if (input.from_port) |v| {
        try body_buf.appendSlice(alloc, "&FromPort=");
        try appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{v}) catch "");
    }
    if (input.group_id) |v| {
        try body_buf.appendSlice(alloc, "&GroupId=");
        try appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.group_name) |v| {
        try body_buf.appendSlice(alloc, "&GroupName=");
        try appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.ip_permissions) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&IpPermissions.item.{d}.FromPort=", .{n}) catch continue;
                try body_buf.appendSlice(alloc, field_prefix);
                if (item.from_port) |fv_1| {
                    try appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{fv_1}) catch "");
                }
            }
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&IpPermissions.item.{d}.IpProtocol=", .{n}) catch continue;
                try body_buf.appendSlice(alloc, field_prefix);
                if (item.ip_protocol) |fv_1| {
                    try appendUrlEncoded(alloc, &body_buf, fv_1);
                }
            }
            if (item.ip_ranges) |lst_1| {
                for (lst_1, 0..) |item_1, idx_1| {
                    const n_1 = idx_1 + 1;
                    {
                        var prefix_buf: [256]u8 = undefined;
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&IpPermissions.item.{d}.IpRanges.item.{d}.CidrIp=", .{n, n_1}) catch continue;
                        try body_buf.appendSlice(alloc, field_prefix);
                        if (item_1.cidr_ip) |fv_2| {
                            try appendUrlEncoded(alloc, &body_buf, fv_2);
                        }
                    }
                    {
                        var prefix_buf: [256]u8 = undefined;
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&IpPermissions.item.{d}.IpRanges.item.{d}.Description=", .{n, n_1}) catch continue;
                        try body_buf.appendSlice(alloc, field_prefix);
                        if (item_1.description) |fv_2| {
                            try appendUrlEncoded(alloc, &body_buf, fv_2);
                        }
                    }
                }
            }
            if (item.ipv_6_ranges) |lst_1| {
                for (lst_1, 0..) |item_1, idx_1| {
                    const n_1 = idx_1 + 1;
                    {
                        var prefix_buf: [256]u8 = undefined;
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&IpPermissions.item.{d}.Ipv6Ranges.item.{d}.CidrIpv6=", .{n, n_1}) catch continue;
                        try body_buf.appendSlice(alloc, field_prefix);
                        if (item_1.cidr_ipv_6) |fv_2| {
                            try appendUrlEncoded(alloc, &body_buf, fv_2);
                        }
                    }
                    {
                        var prefix_buf: [256]u8 = undefined;
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&IpPermissions.item.{d}.Ipv6Ranges.item.{d}.Description=", .{n, n_1}) catch continue;
                        try body_buf.appendSlice(alloc, field_prefix);
                        if (item_1.description) |fv_2| {
                            try appendUrlEncoded(alloc, &body_buf, fv_2);
                        }
                    }
                }
            }
            if (item.prefix_list_ids) |lst_1| {
                for (lst_1, 0..) |item_1, idx_1| {
                    const n_1 = idx_1 + 1;
                    {
                        var prefix_buf: [256]u8 = undefined;
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&IpPermissions.item.{d}.PrefixListIds.item.{d}.Description=", .{n, n_1}) catch continue;
                        try body_buf.appendSlice(alloc, field_prefix);
                        if (item_1.description) |fv_2| {
                            try appendUrlEncoded(alloc, &body_buf, fv_2);
                        }
                    }
                    {
                        var prefix_buf: [256]u8 = undefined;
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&IpPermissions.item.{d}.PrefixListIds.item.{d}.PrefixListId=", .{n, n_1}) catch continue;
                        try body_buf.appendSlice(alloc, field_prefix);
                        if (item_1.prefix_list_id) |fv_2| {
                            try appendUrlEncoded(alloc, &body_buf, fv_2);
                        }
                    }
                }
            }
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&IpPermissions.item.{d}.ToPort=", .{n}) catch continue;
                try body_buf.appendSlice(alloc, field_prefix);
                if (item.to_port) |fv_1| {
                    try appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{fv_1}) catch "");
                }
            }
            if (item.user_id_group_pairs) |lst_1| {
                for (lst_1, 0..) |item_1, idx_1| {
                    const n_1 = idx_1 + 1;
                    {
                        var prefix_buf: [256]u8 = undefined;
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&IpPermissions.item.{d}.UserIdGroupPairs.item.{d}.Description=", .{n, n_1}) catch continue;
                        try body_buf.appendSlice(alloc, field_prefix);
                        if (item_1.description) |fv_2| {
                            try appendUrlEncoded(alloc, &body_buf, fv_2);
                        }
                    }
                    {
                        var prefix_buf: [256]u8 = undefined;
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&IpPermissions.item.{d}.UserIdGroupPairs.item.{d}.GroupId=", .{n, n_1}) catch continue;
                        try body_buf.appendSlice(alloc, field_prefix);
                        if (item_1.group_id) |fv_2| {
                            try appendUrlEncoded(alloc, &body_buf, fv_2);
                        }
                    }
                    {
                        var prefix_buf: [256]u8 = undefined;
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&IpPermissions.item.{d}.UserIdGroupPairs.item.{d}.GroupName=", .{n, n_1}) catch continue;
                        try body_buf.appendSlice(alloc, field_prefix);
                        if (item_1.group_name) |fv_2| {
                            try appendUrlEncoded(alloc, &body_buf, fv_2);
                        }
                    }
                    {
                        var prefix_buf: [256]u8 = undefined;
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&IpPermissions.item.{d}.UserIdGroupPairs.item.{d}.PeeringStatus=", .{n, n_1}) catch continue;
                        try body_buf.appendSlice(alloc, field_prefix);
                        if (item_1.peering_status) |fv_2| {
                            try appendUrlEncoded(alloc, &body_buf, fv_2);
                        }
                    }
                    {
                        var prefix_buf: [256]u8 = undefined;
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&IpPermissions.item.{d}.UserIdGroupPairs.item.{d}.UserId=", .{n, n_1}) catch continue;
                        try body_buf.appendSlice(alloc, field_prefix);
                        if (item_1.user_id) |fv_2| {
                            try appendUrlEncoded(alloc, &body_buf, fv_2);
                        }
                    }
                    {
                        var prefix_buf: [256]u8 = undefined;
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&IpPermissions.item.{d}.UserIdGroupPairs.item.{d}.VpcId=", .{n, n_1}) catch continue;
                        try body_buf.appendSlice(alloc, field_prefix);
                        if (item_1.vpc_id) |fv_2| {
                            try appendUrlEncoded(alloc, &body_buf, fv_2);
                        }
                    }
                    {
                        var prefix_buf: [256]u8 = undefined;
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&IpPermissions.item.{d}.UserIdGroupPairs.item.{d}.VpcPeeringConnectionId=", .{n, n_1}) catch continue;
                        try body_buf.appendSlice(alloc, field_prefix);
                        if (item_1.vpc_peering_connection_id) |fv_2| {
                            try appendUrlEncoded(alloc, &body_buf, fv_2);
                        }
                    }
                }
            }
        }
    }
    if (input.ip_protocol) |v| {
        try body_buf.appendSlice(alloc, "&IpProtocol=");
        try appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.source_security_group_name) |v| {
        try body_buf.appendSlice(alloc, "&SourceSecurityGroupName=");
        try appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.source_security_group_owner_id) |v| {
        try body_buf.appendSlice(alloc, "&SourceSecurityGroupOwnerId=");
        try appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.tag_specifications) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&TagSpecifications.item.{d}.ResourceType=", .{n}) catch continue;
                try body_buf.appendSlice(alloc, field_prefix);
                if (item.resource_type) |fv_1| {
                    try appendUrlEncoded(alloc, &body_buf, @tagName(fv_1));
                }
            }
            if (item.tags) |lst_1| {
                for (lst_1, 0..) |item_1, idx_1| {
                    const n_1 = idx_1 + 1;
                    {
                        var prefix_buf: [256]u8 = undefined;
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&TagSpecifications.item.{d}.Tags.item.{d}.Key=", .{n, n_1}) catch continue;
                        try body_buf.appendSlice(alloc, field_prefix);
                        if (item_1.key) |fv_2| {
                            try appendUrlEncoded(alloc, &body_buf, fv_2);
                        }
                    }
                    {
                        var prefix_buf: [256]u8 = undefined;
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&TagSpecifications.item.{d}.Tags.item.{d}.Value=", .{n, n_1}) catch continue;
                        try body_buf.appendSlice(alloc, field_prefix);
                        if (item_1.value) |fv_2| {
                            try appendUrlEncoded(alloc, &body_buf, fv_2);
                        }
                    }
                }
            }
        }
    }
    if (input.to_port) |v| {
        try body_buf.appendSlice(alloc, "&ToPort=");
        try appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{v}) catch "");
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

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !AuthorizeSecurityGroupIngressOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => break,
            else => {},
        }
    }

    var result: AuthorizeSecurityGroupIngressOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "return")) {
                    result.@"return" = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "securityGroupRuleSet")) {
                    result.security_group_rules = try serde.deserializeSecurityGroupRuleList(&reader, alloc, "item");
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
