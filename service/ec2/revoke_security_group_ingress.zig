const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const IpPermission = @import("ip_permission.zig").IpPermission;
const RevokedSecurityGroupRule = @import("revoked_security_group_rule.zig").RevokedSecurityGroupRule;

/// Removes the specified inbound (ingress) rules from a security group.
///
/// You can specify rules using either rule IDs or security group rule
/// properties. If you use
/// rule properties, the values that you specify (for example, ports) must match
/// the existing rule's
/// values exactly. Each rule has a protocol, from and to ports, and source
/// (CIDR range,
/// security group, or prefix list). For the TCP and UDP protocols, you must
/// also specify the
/// destination port or range of ports. For the ICMP protocol, you must also
/// specify the ICMP type
/// and code. If the security group rule has a description, you do not need to
/// specify the description
/// to revoke the rule.
///
/// For a default VPC, if the values you specify do not match the existing
/// rule's values,
/// no error is returned, and the output describes the security group rules that
/// were not
/// revoked.
///
/// For a non-default VPC, if the values you specify do not match the existing
/// rule's
/// values, an `InvalidPermission.NotFound` client error is returned, and no
/// rules are revoked.
///
/// Amazon Web Services recommends that you describe the security group to
/// verify that the rules were removed.
///
/// Rule changes are propagated to instances within the security group as
/// quickly as possible.
/// However, a small delay might occur.
pub const RevokeSecurityGroupIngressInput = struct {
    /// The CIDR IP address range. You can't specify this parameter when specifying
    /// a source security group.
    cidr_ip: ?[]const u8 = null,

    /// Checks whether you have the required permissions for the action, without
    /// actually making the request,
    /// and provides an error response. If you have the required permissions, the
    /// error response is `DryRunOperation`.
    /// Otherwise, it is `UnauthorizedOperation`.
    dry_run: ?bool = null,

    /// If the protocol is TCP or UDP, this is the start of the port range.
    /// If the protocol is ICMP, this is the ICMP type or -1 (all ICMP types).
    from_port: ?i32 = null,

    /// The ID of the security group.
    group_id: ?[]const u8 = null,

    /// [Default VPC] The name of the security group. You must specify either the
    /// security group ID or the security group name in the request. For security
    /// groups in a
    /// nondefault VPC, you must specify the security group ID.
    group_name: ?[]const u8 = null,

    /// The sets of IP permissions. You can't specify a source security group and a
    /// CIDR IP address range in the same set of permissions.
    ip_permissions: ?[]const IpPermission = null,

    /// The IP protocol name (`tcp`, `udp`, `icmp`) or number
    /// (see [Protocol
    /// Numbers](http://www.iana.org/assignments/protocol-numbers/protocol-numbers.xhtml)).
    /// Use `-1` to specify all.
    ip_protocol: ?[]const u8 = null,

    /// The IDs of the security group rules.
    security_group_rule_ids: ?[]const []const u8 = null,

    /// [Default VPC] The name of the source security group. You can't specify this
    /// parameter
    /// in combination with the following parameters: the CIDR IP address range, the
    /// start of the port range,
    /// the IP protocol, and the end of the port range. The source security group
    /// must be in the same VPC.
    /// To revoke a specific rule for an IP protocol and port range, use a set of IP
    /// permissions instead.
    source_security_group_name: ?[]const u8 = null,

    /// Not supported.
    source_security_group_owner_id: ?[]const u8 = null,

    /// If the protocol is TCP or UDP, this is the end of the port range.
    /// If the protocol is ICMP, this is the ICMP code or -1 (all ICMP codes).
    to_port: ?i32 = null,
};

pub const RevokeSecurityGroupIngressOutput = struct {
    /// Returns `true` if the request succeeds; otherwise, returns an error.
    @"return": ?bool = null,

    /// Details about the revoked security group rules.
    revoked_security_group_rules: ?[]const RevokedSecurityGroupRule = null,

    /// The inbound rules that were unknown to the service. In some cases,
    /// `unknownIpPermissionSet` might be in a different format from the request
    /// parameter.
    unknown_ip_permissions: ?[]const IpPermission = null,

    allocator: std.mem.Allocator,

    pub fn deinit(self: *const RevokeSecurityGroupIngressOutput) void {
        _ = self;
    }
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, input: RevokeSecurityGroupIngressInput, options: Options) !RevokeSecurityGroupIngressOutput {
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

fn serializeRequest(alloc: std.mem.Allocator, input: RevokeSecurityGroupIngressInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpoint("ec2", alloc);

    const host = parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = parsePort(endpoint);

    var body_buf: std.ArrayList(u8) = .{};

    try body_buf.appendSlice(alloc, "Action=RevokeSecurityGroupIngress&Version=2016-11-15");
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
                if (item.from_port) |v| {
                    try appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{v}) catch "");
                }
            }
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&IpPermissions.item.{d}.IpProtocol=", .{n}) catch continue;
                try body_buf.appendSlice(alloc, field_prefix);
                if (item.ip_protocol) |v| {
                    try appendUrlEncoded(alloc, &body_buf, v);
                }
            }
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&IpPermissions.item.{d}.ToPort=", .{n}) catch continue;
                try body_buf.appendSlice(alloc, field_prefix);
                if (item.to_port) |v| {
                    try appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{v}) catch "");
                }
            }
        }
    }
    if (input.ip_protocol) |v| {
        try body_buf.appendSlice(alloc, "&IpProtocol=");
        try appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.security_group_rule_ids) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            var prefix_buf: [256]u8 = undefined;
            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SecurityGroupRuleIds.item.{d}=", .{n}) catch continue;
            try body_buf.appendSlice(alloc, field_prefix);
            try appendUrlEncoded(alloc, &body_buf, item);
        }
    }
    if (input.source_security_group_name) |v| {
        try body_buf.appendSlice(alloc, "&SourceSecurityGroupName=");
        try appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.source_security_group_owner_id) |v| {
        try body_buf.appendSlice(alloc, "&SourceSecurityGroupOwnerId=");
        try appendUrlEncoded(alloc, &body_buf, v);
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

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !RevokeSecurityGroupIngressOutput {
    _ = status;
    _ = headers;
    var result: RevokeSecurityGroupIngressOutput = .{ .allocator = alloc };
    if (findElement(body, "return")) |content| {
        result.@"return" = std.mem.eql(u8, content, "true");
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
