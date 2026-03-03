const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const ModifyVerifiedAccessEndpointCidrOptions = @import("modify_verified_access_endpoint_cidr_options.zig").ModifyVerifiedAccessEndpointCidrOptions;
const ModifyVerifiedAccessEndpointLoadBalancerOptions = @import("modify_verified_access_endpoint_load_balancer_options.zig").ModifyVerifiedAccessEndpointLoadBalancerOptions;
const ModifyVerifiedAccessEndpointEniOptions = @import("modify_verified_access_endpoint_eni_options.zig").ModifyVerifiedAccessEndpointEniOptions;
const ModifyVerifiedAccessEndpointRdsOptions = @import("modify_verified_access_endpoint_rds_options.zig").ModifyVerifiedAccessEndpointRdsOptions;
const VerifiedAccessEndpoint = @import("verified_access_endpoint.zig").VerifiedAccessEndpoint;
const serde = @import("serde.zig");

pub const ModifyVerifiedAccessEndpointInput = struct {
    /// The CIDR options.
    cidr_options: ?ModifyVerifiedAccessEndpointCidrOptions = null,

    /// A unique, case-sensitive token that you provide to ensure idempotency of
    /// your
    /// modification request. For more information, see [Ensuring
    /// idempotency](https://docs.aws.amazon.com/ec2/latest/devguide/ec2-api-idempotency.html).
    client_token: ?[]const u8 = null,

    /// A description for the Verified Access endpoint.
    description: ?[]const u8 = null,

    /// Checks whether you have the required permissions for the action, without
    /// actually making the request,
    /// and provides an error response. If you have the required permissions, the
    /// error response is `DryRunOperation`.
    /// Otherwise, it is `UnauthorizedOperation`.
    dry_run: ?bool = null,

    /// The load balancer details if creating the Verified Access endpoint as
    /// `load-balancer`type.
    load_balancer_options: ?ModifyVerifiedAccessEndpointLoadBalancerOptions = null,

    /// The network interface options.
    network_interface_options: ?ModifyVerifiedAccessEndpointEniOptions = null,

    /// The RDS options.
    rds_options: ?ModifyVerifiedAccessEndpointRdsOptions = null,

    /// The ID of the Verified Access endpoint.
    verified_access_endpoint_id: []const u8,

    /// The ID of the Verified Access group.
    verified_access_group_id: ?[]const u8 = null,
};

pub const ModifyVerifiedAccessEndpointOutput = struct {
    /// Details about the Verified Access endpoint.
    verified_access_endpoint: ?VerifiedAccessEndpoint = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ModifyVerifiedAccessEndpointInput, options: CallOptions) !ModifyVerifiedAccessEndpointOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ModifyVerifiedAccessEndpointInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("ec2", "EC2", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var body_buf: std.ArrayList(u8) = .{};

    try body_buf.appendSlice(allocator, "Action=ModifyVerifiedAccessEndpoint&Version=2016-11-15");
    if (input.cidr_options) |v| {
        if (v.port_ranges) |list_d0| {
            for (list_d0, 0..) |item, idx| {
                const n = idx + 1;
                {
                    var prefix_buf: [256]u8 = undefined;
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&CidrOptions.PortRanges.item.{d}.FromPort=", .{n}) catch continue;
                    try body_buf.appendSlice(allocator, field_prefix);
                    if (item.from_port) |fv_1| {
                        try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{fv_1}) catch "");
                    }
                }
                {
                    var prefix_buf: [256]u8 = undefined;
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&CidrOptions.PortRanges.item.{d}.ToPort=", .{n}) catch continue;
                    try body_buf.appendSlice(allocator, field_prefix);
                    if (item.to_port) |fv_1| {
                        try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{fv_1}) catch "");
                    }
                }
            }
        }
    }
    if (input.client_token) |v| {
        try body_buf.appendSlice(allocator, "&ClientToken=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.description) |v| {
        try body_buf.appendSlice(allocator, "&Description=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.dry_run) |v| {
        try body_buf.appendSlice(allocator, "&DryRun=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, if (v) "true" else "false");
    }
    if (input.load_balancer_options) |v| {
        if (v.port) |sv| {
            try body_buf.appendSlice(allocator, "&LoadBalancerOptions.Port=");
            try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{sv}) catch "");
        }
        if (v.port_ranges) |list_d0| {
            for (list_d0, 0..) |item, idx| {
                const n = idx + 1;
                {
                    var prefix_buf: [256]u8 = undefined;
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&LoadBalancerOptions.PortRanges.item.{d}.FromPort=", .{n}) catch continue;
                    try body_buf.appendSlice(allocator, field_prefix);
                    if (item.from_port) |fv_1| {
                        try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{fv_1}) catch "");
                    }
                }
                {
                    var prefix_buf: [256]u8 = undefined;
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&LoadBalancerOptions.PortRanges.item.{d}.ToPort=", .{n}) catch continue;
                    try body_buf.appendSlice(allocator, field_prefix);
                    if (item.to_port) |fv_1| {
                        try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{fv_1}) catch "");
                    }
                }
            }
        }
        if (v.protocol) |sv| {
            try body_buf.appendSlice(allocator, "&LoadBalancerOptions.Protocol=");
            try aws.url.appendUrlEncoded(allocator, &body_buf, @tagName(sv));
        }
        if (v.subnet_ids) |list_d0| {
            for (list_d0, 0..) |item, idx| {
                const n = idx + 1;
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&LoadBalancerOptions.SubnetIds.item.{d}=", .{n}) catch continue;
                try body_buf.appendSlice(allocator, field_prefix);
                try aws.url.appendUrlEncoded(allocator, &body_buf, item);
            }
        }
    }
    if (input.network_interface_options) |v| {
        if (v.port) |sv| {
            try body_buf.appendSlice(allocator, "&NetworkInterfaceOptions.Port=");
            try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{sv}) catch "");
        }
        if (v.port_ranges) |list_d0| {
            for (list_d0, 0..) |item, idx| {
                const n = idx + 1;
                {
                    var prefix_buf: [256]u8 = undefined;
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&NetworkInterfaceOptions.PortRanges.item.{d}.FromPort=", .{n}) catch continue;
                    try body_buf.appendSlice(allocator, field_prefix);
                    if (item.from_port) |fv_1| {
                        try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{fv_1}) catch "");
                    }
                }
                {
                    var prefix_buf: [256]u8 = undefined;
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&NetworkInterfaceOptions.PortRanges.item.{d}.ToPort=", .{n}) catch continue;
                    try body_buf.appendSlice(allocator, field_prefix);
                    if (item.to_port) |fv_1| {
                        try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{fv_1}) catch "");
                    }
                }
            }
        }
        if (v.protocol) |sv| {
            try body_buf.appendSlice(allocator, "&NetworkInterfaceOptions.Protocol=");
            try aws.url.appendUrlEncoded(allocator, &body_buf, @tagName(sv));
        }
    }
    if (input.rds_options) |v| {
        if (v.port) |sv| {
            try body_buf.appendSlice(allocator, "&RdsOptions.Port=");
            try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{sv}) catch "");
        }
        if (v.rds_endpoint) |sv| {
            try body_buf.appendSlice(allocator, "&RdsOptions.RdsEndpoint=");
            try aws.url.appendUrlEncoded(allocator, &body_buf, sv);
        }
        if (v.subnet_ids) |list_d0| {
            for (list_d0, 0..) |item, idx| {
                const n = idx + 1;
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&RdsOptions.SubnetIds.item.{d}=", .{n}) catch continue;
                try body_buf.appendSlice(allocator, field_prefix);
                try aws.url.appendUrlEncoded(allocator, &body_buf, item);
            }
        }
    }
    try body_buf.appendSlice(allocator, "&VerifiedAccessEndpointId=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.verified_access_endpoint_id);
    if (input.verified_access_group_id) |v| {
        try body_buf.appendSlice(allocator, "&VerifiedAccessGroupId=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ModifyVerifiedAccessEndpointOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => break,
            else => {},
        }
    }

    var result: ModifyVerifiedAccessEndpointOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "verifiedAccessEndpoint")) {
                    result.verified_access_endpoint = try serde.deserializeVerifiedAccessEndpoint(allocator, &reader);
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
