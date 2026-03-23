const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const IpamPoolAllocation = @import("ipam_pool_allocation.zig").IpamPoolAllocation;
const serde = @import("serde.zig");

pub const AllocateIpamPoolCidrInput = struct {
    /// Include a particular CIDR range that can be returned by the pool. Allowed
    /// CIDRs are only allowed if using netmask length for allocation.
    allowed_cidrs: ?[]const []const u8 = null,

    /// The CIDR you would like to allocate from the IPAM pool. Note the following:
    ///
    /// * If there is no DefaultNetmaskLength allocation rule set on the pool, you
    ///   must specify either the NetmaskLength or the CIDR.
    ///
    /// * If the DefaultNetmaskLength allocation rule is set on the pool, you can
    ///   specify either the NetmaskLength or the CIDR and the DefaultNetmaskLength
    ///   allocation rule will be ignored.
    ///
    /// Possible values: Any available IPv4 or IPv6 CIDR.
    cidr: ?[]const u8 = null,

    /// A unique, case-sensitive identifier that you provide to ensure the
    /// idempotency of the request. For more information, see [Ensuring
    /// idempotency](https://docs.aws.amazon.com/ec2/latest/devguide/ec2-api-idempotency.html).
    client_token: ?[]const u8 = null,

    /// A description for the allocation.
    description: ?[]const u8 = null,

    /// Exclude a particular CIDR range from being returned by the pool. Disallowed
    /// CIDRs are only allowed if using netmask length for allocation.
    disallowed_cidrs: ?[]const []const u8 = null,

    /// A check for whether you have the required permissions for the action without
    /// actually making the request
    /// and provides an error response. If you have the required permissions, the
    /// error response is `DryRunOperation`.
    /// Otherwise, it is `UnauthorizedOperation`.
    dry_run: ?bool = null,

    /// The ID of the IPAM pool from which you would like to allocate a CIDR.
    ipam_pool_id: []const u8,

    /// The netmask length of the CIDR you would like to allocate from the IPAM
    /// pool. Note the following:
    ///
    /// * If there is no DefaultNetmaskLength allocation rule set on the pool, you
    ///   must specify either the NetmaskLength or the CIDR.
    ///
    /// * If the DefaultNetmaskLength allocation rule is set on the pool, you can
    ///   specify either the NetmaskLength or the CIDR and the DefaultNetmaskLength
    ///   allocation rule will be ignored.
    ///
    /// Possible netmask lengths for IPv4 addresses are 0 - 32. Possible netmask
    /// lengths for IPv6 addresses are 0 - 128.
    netmask_length: ?i32 = null,

    /// A preview of the next available CIDR in a pool.
    preview_next_cidr: ?bool = null,
};

pub const AllocateIpamPoolCidrOutput = struct {
    /// Information about the allocation created.
    ipam_pool_allocation: ?IpamPoolAllocation = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: AllocateIpamPoolCidrInput, options: CallOptions) !AllocateIpamPoolCidrOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: AllocateIpamPoolCidrInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("ec2", "EC2", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var body_buf: std.ArrayList(u8) = .{};

    try body_buf.appendSlice(allocator, "Action=AllocateIpamPoolCidr&Version=2016-11-15");
    if (input.allowed_cidrs) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            var prefix_buf: [256]u8 = undefined;
            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&AllowedCidr.{d}=", .{n}) catch continue;
            try body_buf.appendSlice(allocator, field_prefix);
            try aws.url.appendUrlEncoded(allocator, &body_buf, item);
        }
    }
    if (input.cidr) |v| {
        try body_buf.appendSlice(allocator, "&Cidr=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.client_token) |v| {
        try body_buf.appendSlice(allocator, "&ClientToken=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.description) |v| {
        try body_buf.appendSlice(allocator, "&Description=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.disallowed_cidrs) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            var prefix_buf: [256]u8 = undefined;
            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&DisallowedCidr.{d}=", .{n}) catch continue;
            try body_buf.appendSlice(allocator, field_prefix);
            try aws.url.appendUrlEncoded(allocator, &body_buf, item);
        }
    }
    if (input.dry_run) |v| {
        try body_buf.appendSlice(allocator, "&DryRun=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, if (v) "true" else "false");
    }
    try body_buf.appendSlice(allocator, "&IpamPoolId=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.ipam_pool_id);
    if (input.netmask_length) |v| {
        try body_buf.appendSlice(allocator, "&NetmaskLength=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{v}) catch "");
    }
    if (input.preview_next_cidr) |v| {
        try body_buf.appendSlice(allocator, "&PreviewNextCidr=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, if (v) "true" else "false");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !AllocateIpamPoolCidrOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => break,
            else => {},
        }
    }

    var result: AllocateIpamPoolCidrOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "ipamPoolAllocation")) {
                    result.ipam_pool_allocation = try serde.deserializeIpamPoolAllocation(allocator, &reader);
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
