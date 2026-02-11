const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const IcmpTypeCode = @import("icmp_type_code.zig").IcmpTypeCode;
const PortRange = @import("port_range.zig").PortRange;
const RuleAction = @import("rule_action.zig").RuleAction;

/// Replaces an entry (rule) in a network ACL. For more information, see
/// [Network
/// ACLs](https://docs.aws.amazon.com/vpc/latest/userguide/vpc-network-acls.html) in the
/// *Amazon VPC User Guide*.
pub const ReplaceNetworkAclEntryInput = struct {
    /// The IPv4 network range to allow or deny, in CIDR notation (for example
    /// `172.16.0.0/24`).
    cidr_block: ?[]const u8 = null,

    /// Checks whether you have the required permissions for the action, without
    /// actually making the request,
    /// and provides an error response. If you have the required permissions, the
    /// error response is `DryRunOperation`.
    /// Otherwise, it is `UnauthorizedOperation`.
    dry_run: ?bool = null,

    /// Indicates whether to replace the egress rule.
    ///
    /// Default: If no value is specified, we replace the ingress rule.
    egress: bool,

    /// ICMP protocol: The ICMP or ICMPv6 type and code. Required if specifying
    /// protocol
    /// 1 (ICMP) or protocol 58 (ICMPv6) with an IPv6 CIDR block.
    icmp_type_code: ?IcmpTypeCode = null,

    /// The IPv6 network range to allow or deny, in CIDR notation (for example
    /// `2001:bd8:1234:1a00::/64`).
    ipv_6_cidr_block: ?[]const u8 = null,

    /// The ID of the ACL.
    network_acl_id: []const u8,

    /// TCP or UDP protocols: The range of ports the rule applies to.
    /// Required if specifying protocol 6 (TCP) or 17 (UDP).
    port_range: ?PortRange = null,

    /// The protocol number. A value of "-1" means all protocols. If you specify
    /// "-1" or a
    /// protocol number other than "6" (TCP), "17" (UDP), or "1" (ICMP), traffic on
    /// all ports is
    /// allowed, regardless of any ports or ICMP types or codes that you specify. If
    /// you specify
    /// protocol "58" (ICMPv6) and specify an IPv4 CIDR block, traffic for all ICMP
    /// types and
    /// codes allowed, regardless of any that you specify. If you specify protocol
    /// "58" (ICMPv6)
    /// and specify an IPv6 CIDR block, you must specify an ICMP type and code.
    protocol: []const u8,

    /// Indicates whether to allow or deny the traffic that matches the rule.
    rule_action: RuleAction,

    /// The rule number of the entry to replace.
    rule_number: i32,
};

pub const ReplaceNetworkAclEntryOutput = struct {

    allocator: std.mem.Allocator,

    pub fn deinit(self: *const ReplaceNetworkAclEntryOutput) void {
        _ = self;
    }
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, input: ReplaceNetworkAclEntryInput, options: Options) !ReplaceNetworkAclEntryOutput {
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

fn serializeRequest(alloc: std.mem.Allocator, input: ReplaceNetworkAclEntryInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpoint("ec2", alloc);

    const host = parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = parsePort(endpoint);

    var body_buf: std.ArrayList(u8) = .{};

    try body_buf.appendSlice(alloc, "Action=ReplaceNetworkAclEntry&Version=2016-11-15");
    if (input.cidr_block) |v| {
        try body_buf.appendSlice(alloc, "&CidrBlock=");
        try appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.dry_run) |v| {
        try body_buf.appendSlice(alloc, "&DryRun=");
        try appendUrlEncoded(alloc, &body_buf, if (v) "true" else "false");
    }
    try body_buf.appendSlice(alloc, "&Egress=");
    try appendUrlEncoded(alloc, &body_buf, if (input.egress) "true" else "false");
    if (input.icmp_type_code) |v| {
        if (v.code) |sv| {
            try body_buf.appendSlice(alloc, "&IcmpTypeCode.Code=");
            try appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{sv}) catch "");
        }
        if (v.@"type") |sv| {
            try body_buf.appendSlice(alloc, "&IcmpTypeCode.Type=");
            try appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{sv}) catch "");
        }
    }
    if (input.ipv_6_cidr_block) |v| {
        try body_buf.appendSlice(alloc, "&Ipv6CidrBlock=");
        try appendUrlEncoded(alloc, &body_buf, v);
    }
    try body_buf.appendSlice(alloc, "&NetworkAclId=");
    try appendUrlEncoded(alloc, &body_buf, input.network_acl_id);
    if (input.port_range) |v| {
        if (v.from) |sv| {
            try body_buf.appendSlice(alloc, "&PortRange.From=");
            try appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{sv}) catch "");
        }
        if (v.to) |sv| {
            try body_buf.appendSlice(alloc, "&PortRange.To=");
            try appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{sv}) catch "");
        }
    }
    try body_buf.appendSlice(alloc, "&Protocol=");
    try appendUrlEncoded(alloc, &body_buf, input.protocol);
    try body_buf.appendSlice(alloc, "&RuleAction=");
    try appendUrlEncoded(alloc, &body_buf, @tagName(input.rule_action));
    try body_buf.appendSlice(alloc, "&RuleNumber=");
    try appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{input.rule_number}) catch "");

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

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !ReplaceNetworkAclEntryOutput {
    _ = status;
    _ = headers;
    _ = body;
    const result: ReplaceNetworkAclEntryOutput = .{ .allocator = alloc };

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
