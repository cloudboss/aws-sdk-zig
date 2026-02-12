const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const DnsOptionsSpecification = @import("dns_options_specification.zig").DnsOptionsSpecification;
const IpAddressType = @import("ip_address_type.zig").IpAddressType;
const SubnetConfiguration = @import("subnet_configuration.zig").SubnetConfiguration;

/// Modifies attributes of a specified VPC endpoint. The attributes that you can
/// modify
/// depend on the type of VPC endpoint (interface, gateway, or Gateway Load
/// Balancer). For more information,
/// see the [Amazon Web Services PrivateLink
/// Guide](https://docs.aws.amazon.com/vpc/latest/privatelink/).
pub const ModifyVpcEndpointInput = struct {
    /// (Gateway endpoint) The IDs of the route tables to associate with the
    /// endpoint.
    add_route_table_ids: ?[]const []const u8 = null,

    /// (Interface endpoint) The IDs of the security groups to associate with the
    /// endpoint network interfaces.
    add_security_group_ids: ?[]const []const u8 = null,

    /// (Interface and Gateway Load Balancer endpoints) The IDs of the subnets in
    /// which to serve the endpoint.
    /// For a Gateway Load Balancer endpoint, you can specify only one subnet.
    add_subnet_ids: ?[]const []const u8 = null,

    /// The DNS options for the endpoint.
    dns_options: ?DnsOptionsSpecification = null,

    /// Checks whether you have the required permissions for the action, without
    /// actually making the request,
    /// and provides an error response. If you have the required permissions, the
    /// error response is `DryRunOperation`.
    /// Otherwise, it is `UnauthorizedOperation`.
    dry_run: ?bool = null,

    /// The IP address type for the endpoint.
    ip_address_type: ?IpAddressType = null,

    /// (Interface and gateway endpoints) A policy to attach to the endpoint that
    /// controls access to the service. The policy must
    /// be in valid JSON format.
    policy_document: ?[]const u8 = null,

    /// (Interface endpoint) Indicates whether a private hosted zone is associated
    /// with the VPC.
    private_dns_enabled: ?bool = null,

    /// (Gateway endpoint) The IDs of the route tables to disassociate from the
    /// endpoint.
    remove_route_table_ids: ?[]const []const u8 = null,

    /// (Interface endpoint) The IDs of the security groups to disassociate from the
    /// endpoint network interfaces.
    remove_security_group_ids: ?[]const []const u8 = null,

    /// (Interface endpoint) The IDs of the subnets from which to remove the
    /// endpoint.
    remove_subnet_ids: ?[]const []const u8 = null,

    /// (Gateway endpoint) Specify `true` to reset the policy document to the
    /// default policy. The default policy allows full access to the service.
    reset_policy: ?bool = null,

    /// The subnet configurations for the endpoint.
    subnet_configurations: ?[]const SubnetConfiguration = null,

    /// The ID of the endpoint.
    vpc_endpoint_id: []const u8,
};

pub const ModifyVpcEndpointOutput = struct {
    /// Returns `true` if the request succeeds; otherwise, it returns an error.
    @"return": ?bool = null,

    _arena: std.heap.ArenaAllocator = undefined,

    pub fn deinit(self: *ModifyVpcEndpointOutput) void {
        self._arena.deinit();
    }
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, input: ModifyVpcEndpointInput, options: Options) !ModifyVpcEndpointOutput {
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

fn serializeRequest(alloc: std.mem.Allocator, input: ModifyVpcEndpointInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpoint("ec2", alloc);

    const host = parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = parsePort(endpoint);

    var body_buf: std.ArrayList(u8) = .{};

    try body_buf.appendSlice(alloc, "Action=ModifyVpcEndpoint&Version=2016-11-15");
    if (input.add_route_table_ids) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            var prefix_buf: [256]u8 = undefined;
            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&AddRouteTableIds.item.{d}=", .{n}) catch continue;
            try body_buf.appendSlice(alloc, field_prefix);
            try appendUrlEncoded(alloc, &body_buf, item);
        }
    }
    if (input.add_security_group_ids) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            var prefix_buf: [256]u8 = undefined;
            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&AddSecurityGroupIds.item.{d}=", .{n}) catch continue;
            try body_buf.appendSlice(alloc, field_prefix);
            try appendUrlEncoded(alloc, &body_buf, item);
        }
    }
    if (input.add_subnet_ids) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            var prefix_buf: [256]u8 = undefined;
            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&AddSubnetIds.item.{d}=", .{n}) catch continue;
            try body_buf.appendSlice(alloc, field_prefix);
            try appendUrlEncoded(alloc, &body_buf, item);
        }
    }
    if (input.dns_options) |v| {
        if (v.dns_record_ip_type) |sv| {
            try body_buf.appendSlice(alloc, "&DnsOptions.DnsRecordIpType=");
            try appendUrlEncoded(alloc, &body_buf, @tagName(sv));
        }
        if (v.private_dns_only_for_inbound_resolver_endpoint) |sv| {
            try body_buf.appendSlice(alloc, "&DnsOptions.PrivateDnsOnlyForInboundResolverEndpoint=");
            try appendUrlEncoded(alloc, &body_buf, if (sv) "true" else "false");
        }
        if (v.private_dns_preference) |sv| {
            try body_buf.appendSlice(alloc, "&DnsOptions.PrivateDnsPreference=");
            try appendUrlEncoded(alloc, &body_buf, sv);
        }
    }
    if (input.dry_run) |v| {
        try body_buf.appendSlice(alloc, "&DryRun=");
        try appendUrlEncoded(alloc, &body_buf, if (v) "true" else "false");
    }
    if (input.ip_address_type) |v| {
        try body_buf.appendSlice(alloc, "&IpAddressType=");
        try appendUrlEncoded(alloc, &body_buf, @tagName(v));
    }
    if (input.policy_document) |v| {
        try body_buf.appendSlice(alloc, "&PolicyDocument=");
        try appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.private_dns_enabled) |v| {
        try body_buf.appendSlice(alloc, "&PrivateDnsEnabled=");
        try appendUrlEncoded(alloc, &body_buf, if (v) "true" else "false");
    }
    if (input.remove_route_table_ids) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            var prefix_buf: [256]u8 = undefined;
            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&RemoveRouteTableIds.item.{d}=", .{n}) catch continue;
            try body_buf.appendSlice(alloc, field_prefix);
            try appendUrlEncoded(alloc, &body_buf, item);
        }
    }
    if (input.remove_security_group_ids) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            var prefix_buf: [256]u8 = undefined;
            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&RemoveSecurityGroupIds.item.{d}=", .{n}) catch continue;
            try body_buf.appendSlice(alloc, field_prefix);
            try appendUrlEncoded(alloc, &body_buf, item);
        }
    }
    if (input.remove_subnet_ids) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            var prefix_buf: [256]u8 = undefined;
            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&RemoveSubnetIds.item.{d}=", .{n}) catch continue;
            try body_buf.appendSlice(alloc, field_prefix);
            try appendUrlEncoded(alloc, &body_buf, item);
        }
    }
    if (input.reset_policy) |v| {
        try body_buf.appendSlice(alloc, "&ResetPolicy=");
        try appendUrlEncoded(alloc, &body_buf, if (v) "true" else "false");
    }
    if (input.subnet_configurations) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SubnetConfigurations.item.{d}.Ipv4=", .{n}) catch continue;
                try body_buf.appendSlice(alloc, field_prefix);
                if (item.ipv_4) |v| {
                    try appendUrlEncoded(alloc, &body_buf, v);
                }
            }
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SubnetConfigurations.item.{d}.Ipv6=", .{n}) catch continue;
                try body_buf.appendSlice(alloc, field_prefix);
                if (item.ipv_6) |v| {
                    try appendUrlEncoded(alloc, &body_buf, v);
                }
            }
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SubnetConfigurations.item.{d}.SubnetId=", .{n}) catch continue;
                try body_buf.appendSlice(alloc, field_prefix);
                if (item.subnet_id) |v| {
                    try appendUrlEncoded(alloc, &body_buf, v);
                }
            }
        }
    }
    try body_buf.appendSlice(alloc, "&VpcEndpointId=");
    try appendUrlEncoded(alloc, &body_buf, input.vpc_endpoint_id);

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

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !ModifyVpcEndpointOutput {
    _ = status;
    _ = headers;
    _ = alloc;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => break,
            else => {},
        }
    }

    var result: ModifyVpcEndpointOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "return")) {
                    result.@"return" = std.mem.eql(u8, try reader.readElementText(), "true");
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
