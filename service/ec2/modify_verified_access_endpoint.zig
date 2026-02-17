const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
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

    _arena: std.heap.ArenaAllocator = undefined,

    pub fn deinit(self: *ModifyVerifiedAccessEndpointOutput) void {
        self._arena.deinit();
    }
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, input: ModifyVerifiedAccessEndpointInput, options: Options) !ModifyVerifiedAccessEndpointOutput {
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

fn serializeRequest(alloc: std.mem.Allocator, input: ModifyVerifiedAccessEndpointInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpoint("ec2", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var body_buf: std.ArrayList(u8) = .{};

    try body_buf.appendSlice(alloc, "Action=ModifyVerifiedAccessEndpoint&Version=2016-11-15");
    if (input.cidr_options) |v| {
        if (v.port_ranges) |list_d0| {
            for (list_d0, 0..) |item, idx| {
                const n = idx + 1;
                {
                    var prefix_buf: [256]u8 = undefined;
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&CidrOptions.PortRanges.item.{d}.FromPort=", .{n}) catch continue;
                    try body_buf.appendSlice(alloc, field_prefix);
                    if (item.from_port) |fv_1| {
                        try aws.url.appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{fv_1}) catch "");
                    }
                }
                {
                    var prefix_buf: [256]u8 = undefined;
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&CidrOptions.PortRanges.item.{d}.ToPort=", .{n}) catch continue;
                    try body_buf.appendSlice(alloc, field_prefix);
                    if (item.to_port) |fv_1| {
                        try aws.url.appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{fv_1}) catch "");
                    }
                }
            }
        }
    }
    if (input.client_token) |v| {
        try body_buf.appendSlice(alloc, "&ClientToken=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.description) |v| {
        try body_buf.appendSlice(alloc, "&Description=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.dry_run) |v| {
        try body_buf.appendSlice(alloc, "&DryRun=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, if (v) "true" else "false");
    }
    if (input.load_balancer_options) |v| {
        if (v.port) |sv| {
            try body_buf.appendSlice(alloc, "&LoadBalancerOptions.Port=");
            try aws.url.appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{sv}) catch "");
        }
        if (v.port_ranges) |list_d0| {
            for (list_d0, 0..) |item, idx| {
                const n = idx + 1;
                {
                    var prefix_buf: [256]u8 = undefined;
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&LoadBalancerOptions.PortRanges.item.{d}.FromPort=", .{n}) catch continue;
                    try body_buf.appendSlice(alloc, field_prefix);
                    if (item.from_port) |fv_1| {
                        try aws.url.appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{fv_1}) catch "");
                    }
                }
                {
                    var prefix_buf: [256]u8 = undefined;
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&LoadBalancerOptions.PortRanges.item.{d}.ToPort=", .{n}) catch continue;
                    try body_buf.appendSlice(alloc, field_prefix);
                    if (item.to_port) |fv_1| {
                        try aws.url.appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{fv_1}) catch "");
                    }
                }
            }
        }
        if (v.protocol) |sv| {
            try body_buf.appendSlice(alloc, "&LoadBalancerOptions.Protocol=");
            try aws.url.appendUrlEncoded(alloc, &body_buf, @tagName(sv));
        }
        if (v.subnet_ids) |list_d0| {
            for (list_d0, 0..) |item, idx| {
                const n = idx + 1;
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&LoadBalancerOptions.SubnetIds.item.{d}=", .{n}) catch continue;
                try body_buf.appendSlice(alloc, field_prefix);
                try aws.url.appendUrlEncoded(alloc, &body_buf, item);
            }
        }
    }
    if (input.network_interface_options) |v| {
        if (v.port) |sv| {
            try body_buf.appendSlice(alloc, "&NetworkInterfaceOptions.Port=");
            try aws.url.appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{sv}) catch "");
        }
        if (v.port_ranges) |list_d0| {
            for (list_d0, 0..) |item, idx| {
                const n = idx + 1;
                {
                    var prefix_buf: [256]u8 = undefined;
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&NetworkInterfaceOptions.PortRanges.item.{d}.FromPort=", .{n}) catch continue;
                    try body_buf.appendSlice(alloc, field_prefix);
                    if (item.from_port) |fv_1| {
                        try aws.url.appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{fv_1}) catch "");
                    }
                }
                {
                    var prefix_buf: [256]u8 = undefined;
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&NetworkInterfaceOptions.PortRanges.item.{d}.ToPort=", .{n}) catch continue;
                    try body_buf.appendSlice(alloc, field_prefix);
                    if (item.to_port) |fv_1| {
                        try aws.url.appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{fv_1}) catch "");
                    }
                }
            }
        }
        if (v.protocol) |sv| {
            try body_buf.appendSlice(alloc, "&NetworkInterfaceOptions.Protocol=");
            try aws.url.appendUrlEncoded(alloc, &body_buf, @tagName(sv));
        }
    }
    if (input.rds_options) |v| {
        if (v.port) |sv| {
            try body_buf.appendSlice(alloc, "&RdsOptions.Port=");
            try aws.url.appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{sv}) catch "");
        }
        if (v.rds_endpoint) |sv| {
            try body_buf.appendSlice(alloc, "&RdsOptions.RdsEndpoint=");
            try aws.url.appendUrlEncoded(alloc, &body_buf, sv);
        }
        if (v.subnet_ids) |list_d0| {
            for (list_d0, 0..) |item, idx| {
                const n = idx + 1;
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&RdsOptions.SubnetIds.item.{d}=", .{n}) catch continue;
                try body_buf.appendSlice(alloc, field_prefix);
                try aws.url.appendUrlEncoded(alloc, &body_buf, item);
            }
        }
    }
    try body_buf.appendSlice(alloc, "&VerifiedAccessEndpointId=");
    try aws.url.appendUrlEncoded(alloc, &body_buf, input.verified_access_endpoint_id);
    if (input.verified_access_group_id) |v| {
        try body_buf.appendSlice(alloc, "&VerifiedAccessGroupId=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, v);
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

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !ModifyVerifiedAccessEndpointOutput {
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
                    result.verified_access_endpoint = try serde.deserializeVerifiedAccessEndpoint(&reader, alloc);
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
    const error_code = aws.xml.findElement(body, "Code") orelse "Unknown";
    const error_message = aws.xml.findElement(body, "Message") orelse "";
    const request_id = aws.xml.findElement(body, "RequestID") orelse "";


    return .{ .unknown = .{
        .code = error_code,
        .message = error_message,
        .request_id = request_id,
        .http_status = status,
    } };
}
