const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const IpamPoolAllocation = @import("ipam_pool_allocation.zig").IpamPoolAllocation;

/// Allocate a CIDR from an IPAM pool. The Region you use should be the IPAM
/// pool locale. The locale is the Amazon Web Services Region where this IPAM
/// pool is available for allocations.
///
/// In IPAM, an allocation is a CIDR assignment from an IPAM pool to another
/// IPAM pool or to a resource. For more information, see [Allocate
/// CIDRs](https://docs.aws.amazon.com/vpc/latest/ipam/allocate-cidrs-ipam.html)
/// in the *Amazon VPC IPAM User Guide*.
///
/// **Note:**
///
/// This action creates an allocation with strong consistency. The returned CIDR
/// will not overlap with any other allocations from the same pool.
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

    allocator: std.mem.Allocator,

    pub fn deinit(self: *const AllocateIpamPoolCidrOutput) void {
        _ = self;
    }
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, input: AllocateIpamPoolCidrInput, options: Options) !AllocateIpamPoolCidrOutput {
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

fn serializeRequest(alloc: std.mem.Allocator, input: AllocateIpamPoolCidrInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpoint("ec2", alloc);

    const host = parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = parsePort(endpoint);

    var body_buf: std.ArrayList(u8) = .{};

    try body_buf.appendSlice(alloc, "Action=AllocateIpamPoolCidr&Version=2016-11-15");
    if (input.allowed_cidrs) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            var prefix_buf: [256]u8 = undefined;
            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&AllowedCidrs.item.{d}=", .{n}) catch continue;
            try body_buf.appendSlice(alloc, field_prefix);
            try appendUrlEncoded(alloc, &body_buf, item);
        }
    }
    if (input.cidr) |v| {
        try body_buf.appendSlice(alloc, "&Cidr=");
        try appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.client_token) |v| {
        try body_buf.appendSlice(alloc, "&ClientToken=");
        try appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.description) |v| {
        try body_buf.appendSlice(alloc, "&Description=");
        try appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.disallowed_cidrs) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            var prefix_buf: [256]u8 = undefined;
            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&DisallowedCidrs.item.{d}=", .{n}) catch continue;
            try body_buf.appendSlice(alloc, field_prefix);
            try appendUrlEncoded(alloc, &body_buf, item);
        }
    }
    if (input.dry_run) |v| {
        try body_buf.appendSlice(alloc, "&DryRun=");
        try appendUrlEncoded(alloc, &body_buf, if (v) "true" else "false");
    }
    try body_buf.appendSlice(alloc, "&IpamPoolId=");
    try appendUrlEncoded(alloc, &body_buf, input.ipam_pool_id);
    if (input.netmask_length) |v| {
        try body_buf.appendSlice(alloc, "&NetmaskLength=");
        try appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{v}) catch "");
    }
    if (input.preview_next_cidr) |v| {
        try body_buf.appendSlice(alloc, "&PreviewNextCidr=");
        try appendUrlEncoded(alloc, &body_buf, if (v) "true" else "false");
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

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !AllocateIpamPoolCidrOutput {
    _ = status;
    _ = headers;
    _ = body;
    const result: AllocateIpamPoolCidrOutput = .{ .allocator = alloc };

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
