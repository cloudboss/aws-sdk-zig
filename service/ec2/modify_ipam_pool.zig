const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const RequestIpamResourceTag = @import("request_ipam_resource_tag.zig").RequestIpamResourceTag;
const IpamPool = @import("ipam_pool.zig").IpamPool;
const serde = @import("serde.zig");

pub const ModifyIpamPoolInput = struct {
    /// Add tag allocation rules to a pool. For more information about allocation
    /// rules, see [Create a top-level
    /// pool](https://docs.aws.amazon.com/vpc/latest/ipam/create-top-ipam.html) in
    /// the *Amazon VPC IPAM User Guide*.
    add_allocation_resource_tags: ?[]const RequestIpamResourceTag = null,

    /// The default netmask length for allocations added to this pool. If, for
    /// example, the CIDR assigned to this pool is 10.0.0.0/8 and you enter 16 here,
    /// new allocations will default to 10.0.0.0/16.
    allocation_default_netmask_length: ?i32 = null,

    /// The maximum netmask length possible for CIDR allocations in this IPAM pool
    /// to be compliant. Possible
    /// netmask lengths for IPv4 addresses are 0 - 32. Possible netmask lengths for
    /// IPv6 addresses are 0 - 128.The maximum netmask
    /// length must be greater than the minimum netmask length.
    allocation_max_netmask_length: ?i32 = null,

    /// The minimum netmask length required for CIDR allocations in this IPAM pool
    /// to be compliant. Possible
    /// netmask lengths for IPv4 addresses are 0 - 32. Possible netmask lengths for
    /// IPv6 addresses are 0 - 128. The minimum netmask
    /// length must be less than the maximum netmask length.
    allocation_min_netmask_length: ?i32 = null,

    /// If true, IPAM will continuously look for resources within the CIDR range of
    /// this pool
    /// and automatically import them as allocations into your IPAM. The CIDRs that
    /// will be allocated for
    /// these resources must not already be allocated to other resources in order
    /// for the import to succeed. IPAM will import
    /// a CIDR regardless of its compliance with the pool's allocation rules, so a
    /// resource might be imported and subsequently
    /// marked as noncompliant. If IPAM discovers multiple CIDRs that overlap, IPAM
    /// will import the largest CIDR only. If IPAM
    /// discovers multiple CIDRs with matching CIDRs, IPAM will randomly import one
    /// of them only.
    ///
    /// A locale must be set on the pool for this feature to work.
    auto_import: ?bool = null,

    /// Clear the default netmask length allocation rule for this pool.
    clear_allocation_default_netmask_length: ?bool = null,

    /// The description of the IPAM pool you want to modify.
    description: ?[]const u8 = null,

    /// A check for whether you have the required permissions for the action without
    /// actually making the request
    /// and provides an error response. If you have the required permissions, the
    /// error response is `DryRunOperation`.
    /// Otherwise, it is `UnauthorizedOperation`.
    dry_run: ?bool = null,

    /// The ID of the IPAM pool you want to modify.
    ipam_pool_id: []const u8,

    /// Remove tag allocation rules from a pool.
    remove_allocation_resource_tags: ?[]const RequestIpamResourceTag = null,
};

pub const ModifyIpamPoolOutput = struct {
    /// The results of the modification.
    ipam_pool: ?IpamPool = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ModifyIpamPoolInput, options: CallOptions) !ModifyIpamPoolOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ModifyIpamPoolInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("ec2", "EC2", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var body_buf: std.ArrayList(u8) = .{};

    try body_buf.appendSlice(allocator, "Action=ModifyIpamPool&Version=2016-11-15");
    if (input.add_allocation_resource_tags) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&AddAllocationResourceTag.{d}.Key=", .{n}) catch continue;
                try body_buf.appendSlice(allocator, field_prefix);
                if (item.key) |fv_1| {
                    try aws.url.appendUrlEncoded(allocator, &body_buf, fv_1);
                }
            }
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&AddAllocationResourceTag.{d}.Value=", .{n}) catch continue;
                try body_buf.appendSlice(allocator, field_prefix);
                if (item.value) |fv_1| {
                    try aws.url.appendUrlEncoded(allocator, &body_buf, fv_1);
                }
            }
        }
    }
    if (input.allocation_default_netmask_length) |v| {
        try body_buf.appendSlice(allocator, "&AllocationDefaultNetmaskLength=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{v}) catch "");
    }
    if (input.allocation_max_netmask_length) |v| {
        try body_buf.appendSlice(allocator, "&AllocationMaxNetmaskLength=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{v}) catch "");
    }
    if (input.allocation_min_netmask_length) |v| {
        try body_buf.appendSlice(allocator, "&AllocationMinNetmaskLength=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{v}) catch "");
    }
    if (input.auto_import) |v| {
        try body_buf.appendSlice(allocator, "&AutoImport=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, if (v) "true" else "false");
    }
    if (input.clear_allocation_default_netmask_length) |v| {
        try body_buf.appendSlice(allocator, "&ClearAllocationDefaultNetmaskLength=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, if (v) "true" else "false");
    }
    if (input.description) |v| {
        try body_buf.appendSlice(allocator, "&Description=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.dry_run) |v| {
        try body_buf.appendSlice(allocator, "&DryRun=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, if (v) "true" else "false");
    }
    try body_buf.appendSlice(allocator, "&IpamPoolId=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.ipam_pool_id);
    if (input.remove_allocation_resource_tags) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&RemoveAllocationResourceTag.{d}.Key=", .{n}) catch continue;
                try body_buf.appendSlice(allocator, field_prefix);
                if (item.key) |fv_1| {
                    try aws.url.appendUrlEncoded(allocator, &body_buf, fv_1);
                }
            }
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&RemoveAllocationResourceTag.{d}.Value=", .{n}) catch continue;
                try body_buf.appendSlice(allocator, field_prefix);
                if (item.value) |fv_1| {
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ModifyIpamPoolOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => break,
            else => {},
        }
    }

    var result: ModifyIpamPoolOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "ipamPool")) {
                    result.ipam_pool = try serde.deserializeIpamPool(allocator, &reader);
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
