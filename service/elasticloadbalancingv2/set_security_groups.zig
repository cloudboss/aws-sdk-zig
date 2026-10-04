const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const EnforceSecurityGroupInboundRulesOnPrivateLinkTrafficEnum = @import("enforce_security_group_inbound_rules_on_private_link_traffic_enum.zig").EnforceSecurityGroupInboundRulesOnPrivateLinkTrafficEnum;
const serde = @import("serde.zig");

pub const SetSecurityGroupsInput = struct {
    /// Indicates whether to evaluate inbound security group rules for traffic sent
    /// to a
    /// Network Load Balancer through Amazon Web Services PrivateLink. Applies only
    /// if the load balancer
    /// has an associated security group. The default is `on`.
    enforce_security_group_inbound_rules_on_private_link_traffic: ?EnforceSecurityGroupInboundRulesOnPrivateLinkTrafficEnum = null,

    /// The Amazon Resource Name (ARN) of the load balancer.
    load_balancer_arn: []const u8,

    /// The IDs of the security groups.
    security_groups: []const []const u8,
};

pub const SetSecurityGroupsOutput = struct {
    /// Indicates whether to evaluate inbound security group rules for traffic sent
    /// to a
    /// Network Load Balancer through Amazon Web Services PrivateLink.
    enforce_security_group_inbound_rules_on_private_link_traffic: ?EnforceSecurityGroupInboundRulesOnPrivateLinkTrafficEnum = null,

    /// The IDs of the security groups associated with the load balancer.
    security_group_ids: ?[]const []const u8 = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: SetSecurityGroupsInput, options: CallOptions) !SetSecurityGroupsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: SetSecurityGroupsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("elasticloadbalancing", "Elastic Load Balancing v2", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=SetSecurityGroups&Version=2015-12-01");
    if (input.enforce_security_group_inbound_rules_on_private_link_traffic) |v| {
        try body_buf.appendSlice(allocator, "&EnforceSecurityGroupInboundRulesOnPrivateLinkTraffic=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v.wireName());
    }
    try body_buf.appendSlice(allocator, "&LoadBalancerArn=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.load_balancer_arn);
    for (input.security_groups, 0..) |item, idx| {
        const n = idx + 1;
        var prefix_buf: [256]u8 = undefined;
        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SecurityGroups.member.{d}=", .{n}) catch continue;
        try body_buf.appendSlice(allocator, field_prefix);
        try aws.url.appendUrlEncoded(allocator, &body_buf, item);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !SetSecurityGroupsOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "SetSecurityGroupsResult")) break;
            },
            else => {},
        }
    }

    var result: SetSecurityGroupsOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "EnforceSecurityGroupInboundRulesOnPrivateLinkTraffic")) {
                    result.enforce_security_group_inbound_rules_on_private_link_traffic = EnforceSecurityGroupInboundRulesOnPrivateLinkTrafficEnum.fromWireName(try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "SecurityGroupIds")) {
                    result.security_group_ids = try serde.deserializeSecurityGroups(allocator, &reader, "member");
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
