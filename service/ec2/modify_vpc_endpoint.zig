const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const DnsOptionsSpecification = @import("dns_options_specification.zig").DnsOptionsSpecification;
const IpAddressType = @import("ip_address_type.zig").IpAddressType;
const SubnetConfiguration = @import("subnet_configuration.zig").SubnetConfiguration;
const serde = @import("serde.zig");

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
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ModifyVpcEndpointInput, options: Options) !ModifyVpcEndpointOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ModifyVpcEndpointInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("ec2", "EC2", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var body_buf: std.ArrayList(u8) = .{};

    try body_buf.appendSlice(allocator, "Action=ModifyVpcEndpoint&Version=2016-11-15");
    if (input.add_route_table_ids) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            var prefix_buf: [256]u8 = undefined;
            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&AddRouteTableId.item.{d}=", .{n}) catch continue;
            try body_buf.appendSlice(allocator, field_prefix);
            try aws.url.appendUrlEncoded(allocator, &body_buf, item);
        }
    }
    if (input.add_security_group_ids) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            var prefix_buf: [256]u8 = undefined;
            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&AddSecurityGroupId.item.{d}=", .{n}) catch continue;
            try body_buf.appendSlice(allocator, field_prefix);
            try aws.url.appendUrlEncoded(allocator, &body_buf, item);
        }
    }
    if (input.add_subnet_ids) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            var prefix_buf: [256]u8 = undefined;
            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&AddSubnetId.item.{d}=", .{n}) catch continue;
            try body_buf.appendSlice(allocator, field_prefix);
            try aws.url.appendUrlEncoded(allocator, &body_buf, item);
        }
    }
    if (input.dns_options) |v| {
        if (v.dns_record_ip_type) |sv| {
            try body_buf.appendSlice(allocator, "&DnsOptions.DnsRecordIpType=");
            try aws.url.appendUrlEncoded(allocator, &body_buf, @tagName(sv));
        }
        if (v.private_dns_only_for_inbound_resolver_endpoint) |sv| {
            try body_buf.appendSlice(allocator, "&DnsOptions.PrivateDnsOnlyForInboundResolverEndpoint=");
            try aws.url.appendUrlEncoded(allocator, &body_buf, if (sv) "true" else "false");
        }
        if (v.private_dns_preference) |sv| {
            try body_buf.appendSlice(allocator, "&DnsOptions.PrivateDnsPreference=");
            try aws.url.appendUrlEncoded(allocator, &body_buf, sv);
        }
        if (v.private_dns_specified_domains) |list_d0| {
            for (list_d0, 0..) |item, idx| {
                const n = idx + 1;
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&DnsOptions.PrivateDnsSpecifiedDomains.item.{d}=", .{n}) catch continue;
                try body_buf.appendSlice(allocator, field_prefix);
                try aws.url.appendUrlEncoded(allocator, &body_buf, item);
            }
        }
    }
    if (input.dry_run) |v| {
        try body_buf.appendSlice(allocator, "&DryRun=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, if (v) "true" else "false");
    }
    if (input.ip_address_type) |v| {
        try body_buf.appendSlice(allocator, "&IpAddressType=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, @tagName(v));
    }
    if (input.policy_document) |v| {
        try body_buf.appendSlice(allocator, "&PolicyDocument=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.private_dns_enabled) |v| {
        try body_buf.appendSlice(allocator, "&PrivateDnsEnabled=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, if (v) "true" else "false");
    }
    if (input.remove_route_table_ids) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            var prefix_buf: [256]u8 = undefined;
            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&RemoveRouteTableId.item.{d}=", .{n}) catch continue;
            try body_buf.appendSlice(allocator, field_prefix);
            try aws.url.appendUrlEncoded(allocator, &body_buf, item);
        }
    }
    if (input.remove_security_group_ids) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            var prefix_buf: [256]u8 = undefined;
            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&RemoveSecurityGroupId.item.{d}=", .{n}) catch continue;
            try body_buf.appendSlice(allocator, field_prefix);
            try aws.url.appendUrlEncoded(allocator, &body_buf, item);
        }
    }
    if (input.remove_subnet_ids) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            var prefix_buf: [256]u8 = undefined;
            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&RemoveSubnetId.item.{d}=", .{n}) catch continue;
            try body_buf.appendSlice(allocator, field_prefix);
            try aws.url.appendUrlEncoded(allocator, &body_buf, item);
        }
    }
    if (input.reset_policy) |v| {
        try body_buf.appendSlice(allocator, "&ResetPolicy=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, if (v) "true" else "false");
    }
    if (input.subnet_configurations) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SubnetConfiguration.item.{d}.Ipv4=", .{n}) catch continue;
                try body_buf.appendSlice(allocator, field_prefix);
                if (item.ipv_4) |fv_1| {
                    try aws.url.appendUrlEncoded(allocator, &body_buf, fv_1);
                }
            }
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SubnetConfiguration.item.{d}.Ipv6=", .{n}) catch continue;
                try body_buf.appendSlice(allocator, field_prefix);
                if (item.ipv_6) |fv_1| {
                    try aws.url.appendUrlEncoded(allocator, &body_buf, fv_1);
                }
            }
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SubnetConfiguration.item.{d}.SubnetId=", .{n}) catch continue;
                try body_buf.appendSlice(allocator, field_prefix);
                if (item.subnet_id) |fv_1| {
                    try aws.url.appendUrlEncoded(allocator, &body_buf, fv_1);
                }
            }
        }
    }
    try body_buf.appendSlice(allocator, "&VpcEndpointId=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.vpc_endpoint_id);

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ModifyVpcEndpointOutput {
    _ = status;
    _ = headers;
    _ = allocator;
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
