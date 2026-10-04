const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const LoadBalancerAttributes = @import("load_balancer_attributes.zig").LoadBalancerAttributes;
const serde = @import("serde.zig");

pub const ModifyLoadBalancerAttributesInput = struct {
    /// The attributes for the load balancer.
    load_balancer_attributes: LoadBalancerAttributes,

    /// The name of the load balancer.
    load_balancer_name: []const u8,
};

pub const ModifyLoadBalancerAttributesOutput = struct {
    /// Information about the load balancer attributes.
    load_balancer_attributes: ?LoadBalancerAttributes = null,

    /// The name of the load balancer.
    load_balancer_name: ?[]const u8 = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ModifyLoadBalancerAttributesInput, options: CallOptions) !ModifyLoadBalancerAttributesOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ModifyLoadBalancerAttributesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("elasticloadbalancing", "Elastic Load Balancing", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=ModifyLoadBalancerAttributes&Version=2012-06-01");
    if (input.load_balancer_attributes.access_log) |sv| {
        if (sv.emit_interval) |sv2| {
            try body_buf.appendSlice(allocator, "&LoadBalancerAttributes.AccessLog.EmitInterval=");
            try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{sv2}) catch "");
        }
        try body_buf.appendSlice(allocator, "&LoadBalancerAttributes.AccessLog.Enabled=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, if (sv.enabled) "true" else "false");
        if (sv.s3_bucket_name) |sv2| {
            try body_buf.appendSlice(allocator, "&LoadBalancerAttributes.AccessLog.S3BucketName=");
            try aws.url.appendUrlEncoded(allocator, &body_buf, sv2);
        }
        if (sv.s3_bucket_prefix) |sv2| {
            try body_buf.appendSlice(allocator, "&LoadBalancerAttributes.AccessLog.S3BucketPrefix=");
            try aws.url.appendUrlEncoded(allocator, &body_buf, sv2);
        }
    }
    if (input.load_balancer_attributes.additional_attributes) |list_d0| {
        for (list_d0, 0..) |item, idx| {
            const n = idx + 1;
            {
                var prefix_buf: [256]u8 = undefined;
                if (item.key) |fv_1| {
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&LoadBalancerAttributes.AdditionalAttributes.member.{d}.Key=", .{n}) catch continue;
                    try body_buf.appendSlice(allocator, field_prefix);
                    try aws.url.appendUrlEncoded(allocator, &body_buf, fv_1);
                }
            }
            {
                var prefix_buf: [256]u8 = undefined;
                if (item.value) |fv_1| {
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&LoadBalancerAttributes.AdditionalAttributes.member.{d}.Value=", .{n}) catch continue;
                    try body_buf.appendSlice(allocator, field_prefix);
                    try aws.url.appendUrlEncoded(allocator, &body_buf, fv_1);
                }
            }
        }
    }
    if (input.load_balancer_attributes.connection_draining) |sv| {
        try body_buf.appendSlice(allocator, "&LoadBalancerAttributes.ConnectionDraining.Enabled=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, if (sv.enabled) "true" else "false");
        if (sv.timeout) |sv2| {
            try body_buf.appendSlice(allocator, "&LoadBalancerAttributes.ConnectionDraining.Timeout=");
            try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{sv2}) catch "");
        }
    }
    if (input.load_balancer_attributes.connection_settings) |sv| {
        try body_buf.appendSlice(allocator, "&LoadBalancerAttributes.ConnectionSettings.IdleTimeout=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{sv.idle_timeout}) catch "");
    }
    if (input.load_balancer_attributes.cross_zone_load_balancing) |sv| {
        try body_buf.appendSlice(allocator, "&LoadBalancerAttributes.CrossZoneLoadBalancing.Enabled=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, if (sv.enabled) "true" else "false");
    }
    try body_buf.appendSlice(allocator, "&LoadBalancerName=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.load_balancer_name);

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ModifyLoadBalancerAttributesOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "ModifyLoadBalancerAttributesResult")) break;
            },
            else => {},
        }
    }

    var result: ModifyLoadBalancerAttributesOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "LoadBalancerAttributes")) {
                    result.load_balancer_attributes = try serde.deserializeLoadBalancerAttributes(allocator, &reader);
                } else if (std.mem.eql(u8, e.local, "LoadBalancerName")) {
                    result.load_balancer_name = try allocator.dupe(u8, try reader.readElementText());
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
