const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const IpPermission = @import("ip_permission.zig").IpPermission;
const TagSpecification = @import("tag_specification.zig").TagSpecification;
const SecurityGroupRule = @import("security_group_rule.zig").SecurityGroupRule;
const serde = @import("serde.zig");

pub const AuthorizeSecurityGroupIngressInput = struct {
    /// The IPv4 address range, in CIDR format.
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
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: AuthorizeSecurityGroupIngressInput, options: CallOptions) !AuthorizeSecurityGroupIngressOutput {
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
            d.* = parseErrorResponse(client.allocator, response.body, response.status) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: AuthorizeSecurityGroupIngressInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("ec2", "EC2", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var body_buf: std.ArrayList(u8) = .{};

    try body_buf.appendSlice(allocator, "Action=AuthorizeSecurityGroupIngress&Version=2016-11-15");
    if (input.cidr_ip) |v| {
        try body_buf.appendSlice(allocator, "&CidrIp=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.dry_run) |v| {
        try body_buf.appendSlice(allocator, "&DryRun=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, if (v) "true" else "false");
    }
    if (input.from_port) |v| {
        try body_buf.appendSlice(allocator, "&FromPort=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{v}) catch "");
    }
    if (input.group_id) |v| {
        try body_buf.appendSlice(allocator, "&GroupId=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.group_name) |v| {
        try body_buf.appendSlice(allocator, "&GroupName=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.ip_permissions) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&IpPermissions.item.{d}.FromPort=", .{n}) catch continue;
                try body_buf.appendSlice(allocator, field_prefix);
                if (item.from_port) |fv_1| {
                    try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{fv_1}) catch "");
                }
            }
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&IpPermissions.item.{d}.IpProtocol=", .{n}) catch continue;
                try body_buf.appendSlice(allocator, field_prefix);
                if (item.ip_protocol) |fv_1| {
                    try aws.url.appendUrlEncoded(allocator, &body_buf, fv_1);
                }
            }
            if (item.ip_ranges) |lst_1| {
                for (lst_1, 0..) |item_1, idx_1| {
                    const n_1 = idx_1 + 1;
                    {
                        var prefix_buf: [256]u8 = undefined;
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&IpPermissions.item.{d}.IpRanges.item.{d}.CidrIp=", .{n, n_1}) catch continue;
                        try body_buf.appendSlice(allocator, field_prefix);
                        if (item_1.cidr_ip) |fv_2| {
                            try aws.url.appendUrlEncoded(allocator, &body_buf, fv_2);
                        }
                    }
                    {
                        var prefix_buf: [256]u8 = undefined;
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&IpPermissions.item.{d}.IpRanges.item.{d}.Description=", .{n, n_1}) catch continue;
                        try body_buf.appendSlice(allocator, field_prefix);
                        if (item_1.description) |fv_2| {
                            try aws.url.appendUrlEncoded(allocator, &body_buf, fv_2);
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
                        try body_buf.appendSlice(allocator, field_prefix);
                        if (item_1.cidr_ipv_6) |fv_2| {
                            try aws.url.appendUrlEncoded(allocator, &body_buf, fv_2);
                        }
                    }
                    {
                        var prefix_buf: [256]u8 = undefined;
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&IpPermissions.item.{d}.Ipv6Ranges.item.{d}.Description=", .{n, n_1}) catch continue;
                        try body_buf.appendSlice(allocator, field_prefix);
                        if (item_1.description) |fv_2| {
                            try aws.url.appendUrlEncoded(allocator, &body_buf, fv_2);
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
                        try body_buf.appendSlice(allocator, field_prefix);
                        if (item_1.description) |fv_2| {
                            try aws.url.appendUrlEncoded(allocator, &body_buf, fv_2);
                        }
                    }
                    {
                        var prefix_buf: [256]u8 = undefined;
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&IpPermissions.item.{d}.PrefixListIds.item.{d}.PrefixListId=", .{n, n_1}) catch continue;
                        try body_buf.appendSlice(allocator, field_prefix);
                        if (item_1.prefix_list_id) |fv_2| {
                            try aws.url.appendUrlEncoded(allocator, &body_buf, fv_2);
                        }
                    }
                }
            }
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&IpPermissions.item.{d}.ToPort=", .{n}) catch continue;
                try body_buf.appendSlice(allocator, field_prefix);
                if (item.to_port) |fv_1| {
                    try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{fv_1}) catch "");
                }
            }
            if (item.user_id_group_pairs) |lst_1| {
                for (lst_1, 0..) |item_1, idx_1| {
                    const n_1 = idx_1 + 1;
                    {
                        var prefix_buf: [256]u8 = undefined;
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&IpPermissions.item.{d}.UserIdGroupPairs.item.{d}.Description=", .{n, n_1}) catch continue;
                        try body_buf.appendSlice(allocator, field_prefix);
                        if (item_1.description) |fv_2| {
                            try aws.url.appendUrlEncoded(allocator, &body_buf, fv_2);
                        }
                    }
                    {
                        var prefix_buf: [256]u8 = undefined;
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&IpPermissions.item.{d}.UserIdGroupPairs.item.{d}.GroupId=", .{n, n_1}) catch continue;
                        try body_buf.appendSlice(allocator, field_prefix);
                        if (item_1.group_id) |fv_2| {
                            try aws.url.appendUrlEncoded(allocator, &body_buf, fv_2);
                        }
                    }
                    {
                        var prefix_buf: [256]u8 = undefined;
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&IpPermissions.item.{d}.UserIdGroupPairs.item.{d}.GroupName=", .{n, n_1}) catch continue;
                        try body_buf.appendSlice(allocator, field_prefix);
                        if (item_1.group_name) |fv_2| {
                            try aws.url.appendUrlEncoded(allocator, &body_buf, fv_2);
                        }
                    }
                    {
                        var prefix_buf: [256]u8 = undefined;
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&IpPermissions.item.{d}.UserIdGroupPairs.item.{d}.PeeringStatus=", .{n, n_1}) catch continue;
                        try body_buf.appendSlice(allocator, field_prefix);
                        if (item_1.peering_status) |fv_2| {
                            try aws.url.appendUrlEncoded(allocator, &body_buf, fv_2);
                        }
                    }
                    {
                        var prefix_buf: [256]u8 = undefined;
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&IpPermissions.item.{d}.UserIdGroupPairs.item.{d}.UserId=", .{n, n_1}) catch continue;
                        try body_buf.appendSlice(allocator, field_prefix);
                        if (item_1.user_id) |fv_2| {
                            try aws.url.appendUrlEncoded(allocator, &body_buf, fv_2);
                        }
                    }
                    {
                        var prefix_buf: [256]u8 = undefined;
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&IpPermissions.item.{d}.UserIdGroupPairs.item.{d}.VpcId=", .{n, n_1}) catch continue;
                        try body_buf.appendSlice(allocator, field_prefix);
                        if (item_1.vpc_id) |fv_2| {
                            try aws.url.appendUrlEncoded(allocator, &body_buf, fv_2);
                        }
                    }
                    {
                        var prefix_buf: [256]u8 = undefined;
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&IpPermissions.item.{d}.UserIdGroupPairs.item.{d}.VpcPeeringConnectionId=", .{n, n_1}) catch continue;
                        try body_buf.appendSlice(allocator, field_prefix);
                        if (item_1.vpc_peering_connection_id) |fv_2| {
                            try aws.url.appendUrlEncoded(allocator, &body_buf, fv_2);
                        }
                    }
                }
            }
        }
    }
    if (input.ip_protocol) |v| {
        try body_buf.appendSlice(allocator, "&IpProtocol=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.source_security_group_name) |v| {
        try body_buf.appendSlice(allocator, "&SourceSecurityGroupName=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.source_security_group_owner_id) |v| {
        try body_buf.appendSlice(allocator, "&SourceSecurityGroupOwnerId=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.tag_specifications) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&TagSpecification.item.{d}.ResourceType=", .{n}) catch continue;
                try body_buf.appendSlice(allocator, field_prefix);
                if (item.resource_type) |fv_1| {
                    try aws.url.appendUrlEncoded(allocator, &body_buf, fv_1.wireName());
                }
            }
            if (item.tags) |lst_1| {
                for (lst_1, 0..) |item_1, idx_1| {
                    const n_1 = idx_1 + 1;
                    {
                        var prefix_buf: [256]u8 = undefined;
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&TagSpecification.item.{d}.Tags.item.{d}.Key=", .{n, n_1}) catch continue;
                        try body_buf.appendSlice(allocator, field_prefix);
                        if (item_1.key) |fv_2| {
                            try aws.url.appendUrlEncoded(allocator, &body_buf, fv_2);
                        }
                    }
                    {
                        var prefix_buf: [256]u8 = undefined;
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&TagSpecification.item.{d}.Tags.item.{d}.Value=", .{n, n_1}) catch continue;
                        try body_buf.appendSlice(allocator, field_prefix);
                        if (item_1.value) |fv_2| {
                            try aws.url.appendUrlEncoded(allocator, &body_buf, fv_2);
                        }
                    }
                }
            }
        }
    }
    if (input.to_port) |v| {
        try body_buf.appendSlice(allocator, "&ToPort=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{v}) catch "");
    }

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !AuthorizeSecurityGroupIngressOutput {
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
                    result.security_group_rules = try serde.deserializeSecurityGroupRuleList(allocator, &reader, "item");
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
