const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const IpPermission = @import("ip_permission.zig").IpPermission;
const SecurityGroupRuleDescription = @import("security_group_rule_description.zig").SecurityGroupRuleDescription;
const serde = @import("serde.zig");

pub const UpdateSecurityGroupRuleDescriptionsEgressInput = struct {
    /// Checks whether you have the required permissions for the action, without
    /// actually making the request,
    /// and provides an error response. If you have the required permissions, the
    /// error response is `DryRunOperation`.
    /// Otherwise, it is `UnauthorizedOperation`.
    dry_run: ?bool = null,

    /// The ID of the security group. You must specify either the security group ID
    /// or the
    /// security group name in the request. For security groups in a nondefault VPC,
    /// you must
    /// specify the security group ID.
    group_id: ?[]const u8 = null,

    /// [Default VPC] The name of the security group. You must specify either the
    /// security group
    /// ID or the security group name.
    group_name: ?[]const u8 = null,

    /// The IP permissions for the security group rule. You must specify either the
    /// IP permissions
    /// or the description.
    ip_permissions: ?[]const IpPermission = null,

    /// The description for the egress security group rules. You must specify either
    /// the
    /// description or the IP permissions.
    security_group_rule_descriptions: ?[]const SecurityGroupRuleDescription = null,
};

pub const UpdateSecurityGroupRuleDescriptionsEgressOutput = struct {
    /// Returns `true` if the request succeeds; otherwise, returns an error.
    @"return": ?bool = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateSecurityGroupRuleDescriptionsEgressInput, options: CallOptions) !UpdateSecurityGroupRuleDescriptionsEgressOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateSecurityGroupRuleDescriptionsEgressInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("ec2", "EC2", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var body_buf: std.ArrayList(u8) = .{};

    try body_buf.appendSlice(allocator, "Action=UpdateSecurityGroupRuleDescriptionsEgress&Version=2016-11-15");
    if (input.dry_run) |v| {
        try body_buf.appendSlice(allocator, "&DryRun=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, if (v) "true" else "false");
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
                if (item.from_port) |fv_1| {
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&IpPermissions.{d}.FromPort=", .{n}) catch continue;
                    try body_buf.appendSlice(allocator, field_prefix);
                    try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{fv_1}) catch "");
                }
            }
            {
                var prefix_buf: [256]u8 = undefined;
                if (item.ip_protocol) |fv_1| {
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&IpPermissions.{d}.IpProtocol=", .{n}) catch continue;
                    try body_buf.appendSlice(allocator, field_prefix);
                    try aws.url.appendUrlEncoded(allocator, &body_buf, fv_1);
                }
            }
            if (item.ip_ranges) |lst_1| {
                for (lst_1, 0..) |item_1, idx_1| {
                    const n_1 = idx_1 + 1;
                    {
                        var prefix_buf: [256]u8 = undefined;
                        if (item_1.cidr_ip) |fv_2| {
                            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&IpPermissions.{d}.IpRanges.{d}.CidrIp=", .{n, n_1}) catch continue;
                            try body_buf.appendSlice(allocator, field_prefix);
                            try aws.url.appendUrlEncoded(allocator, &body_buf, fv_2);
                        }
                    }
                    {
                        var prefix_buf: [256]u8 = undefined;
                        if (item_1.description) |fv_2| {
                            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&IpPermissions.{d}.IpRanges.{d}.Description=", .{n, n_1}) catch continue;
                            try body_buf.appendSlice(allocator, field_prefix);
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
                        if (item_1.cidr_ipv_6) |fv_2| {
                            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&IpPermissions.{d}.Ipv6Ranges.{d}.CidrIpv6=", .{n, n_1}) catch continue;
                            try body_buf.appendSlice(allocator, field_prefix);
                            try aws.url.appendUrlEncoded(allocator, &body_buf, fv_2);
                        }
                    }
                    {
                        var prefix_buf: [256]u8 = undefined;
                        if (item_1.description) |fv_2| {
                            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&IpPermissions.{d}.Ipv6Ranges.{d}.Description=", .{n, n_1}) catch continue;
                            try body_buf.appendSlice(allocator, field_prefix);
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
                        if (item_1.description) |fv_2| {
                            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&IpPermissions.{d}.PrefixListIds.{d}.Description=", .{n, n_1}) catch continue;
                            try body_buf.appendSlice(allocator, field_prefix);
                            try aws.url.appendUrlEncoded(allocator, &body_buf, fv_2);
                        }
                    }
                    {
                        var prefix_buf: [256]u8 = undefined;
                        if (item_1.prefix_list_id) |fv_2| {
                            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&IpPermissions.{d}.PrefixListIds.{d}.PrefixListId=", .{n, n_1}) catch continue;
                            try body_buf.appendSlice(allocator, field_prefix);
                            try aws.url.appendUrlEncoded(allocator, &body_buf, fv_2);
                        }
                    }
                }
            }
            {
                var prefix_buf: [256]u8 = undefined;
                if (item.to_port) |fv_1| {
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&IpPermissions.{d}.ToPort=", .{n}) catch continue;
                    try body_buf.appendSlice(allocator, field_prefix);
                    try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{fv_1}) catch "");
                }
            }
            if (item.user_id_group_pairs) |lst_1| {
                for (lst_1, 0..) |item_1, idx_1| {
                    const n_1 = idx_1 + 1;
                    {
                        var prefix_buf: [256]u8 = undefined;
                        if (item_1.description) |fv_2| {
                            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&IpPermissions.{d}.Groups.{d}.Description=", .{n, n_1}) catch continue;
                            try body_buf.appendSlice(allocator, field_prefix);
                            try aws.url.appendUrlEncoded(allocator, &body_buf, fv_2);
                        }
                    }
                    {
                        var prefix_buf: [256]u8 = undefined;
                        if (item_1.group_id) |fv_2| {
                            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&IpPermissions.{d}.Groups.{d}.GroupId=", .{n, n_1}) catch continue;
                            try body_buf.appendSlice(allocator, field_prefix);
                            try aws.url.appendUrlEncoded(allocator, &body_buf, fv_2);
                        }
                    }
                    {
                        var prefix_buf: [256]u8 = undefined;
                        if (item_1.group_name) |fv_2| {
                            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&IpPermissions.{d}.Groups.{d}.GroupName=", .{n, n_1}) catch continue;
                            try body_buf.appendSlice(allocator, field_prefix);
                            try aws.url.appendUrlEncoded(allocator, &body_buf, fv_2);
                        }
                    }
                    {
                        var prefix_buf: [256]u8 = undefined;
                        if (item_1.peering_status) |fv_2| {
                            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&IpPermissions.{d}.Groups.{d}.PeeringStatus=", .{n, n_1}) catch continue;
                            try body_buf.appendSlice(allocator, field_prefix);
                            try aws.url.appendUrlEncoded(allocator, &body_buf, fv_2);
                        }
                    }
                    {
                        var prefix_buf: [256]u8 = undefined;
                        if (item_1.user_id) |fv_2| {
                            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&IpPermissions.{d}.Groups.{d}.UserId=", .{n, n_1}) catch continue;
                            try body_buf.appendSlice(allocator, field_prefix);
                            try aws.url.appendUrlEncoded(allocator, &body_buf, fv_2);
                        }
                    }
                    {
                        var prefix_buf: [256]u8 = undefined;
                        if (item_1.vpc_id) |fv_2| {
                            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&IpPermissions.{d}.Groups.{d}.VpcId=", .{n, n_1}) catch continue;
                            try body_buf.appendSlice(allocator, field_prefix);
                            try aws.url.appendUrlEncoded(allocator, &body_buf, fv_2);
                        }
                    }
                    {
                        var prefix_buf: [256]u8 = undefined;
                        if (item_1.vpc_peering_connection_id) |fv_2| {
                            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&IpPermissions.{d}.Groups.{d}.VpcPeeringConnectionId=", .{n, n_1}) catch continue;
                            try body_buf.appendSlice(allocator, field_prefix);
                            try aws.url.appendUrlEncoded(allocator, &body_buf, fv_2);
                        }
                    }
                }
            }
        }
    }
    if (input.security_group_rule_descriptions) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            {
                var prefix_buf: [256]u8 = undefined;
                if (item.description) |fv_1| {
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SecurityGroupRuleDescription.{d}.Description=", .{n}) catch continue;
                    try body_buf.appendSlice(allocator, field_prefix);
                    try aws.url.appendUrlEncoded(allocator, &body_buf, fv_1);
                }
            }
            {
                var prefix_buf: [256]u8 = undefined;
                if (item.security_group_rule_id) |fv_1| {
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SecurityGroupRuleDescription.{d}.SecurityGroupRuleId=", .{n}) catch continue;
                    try body_buf.appendSlice(allocator, field_prefix);
                    try aws.url.appendUrlEncoded(allocator, &body_buf, fv_1);
                }
            }
        }
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateSecurityGroupRuleDescriptionsEgressOutput {
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

    var result: UpdateSecurityGroupRuleDescriptionsEgressOutput = .{};
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
