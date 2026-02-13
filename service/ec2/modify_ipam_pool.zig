const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const RequestIpamResourceTag = @import("request_ipam_resource_tag.zig").RequestIpamResourceTag;
const IpamPool = @import("ipam_pool.zig").IpamPool;
const serde = @import("serde.zig");

/// Modify the configurations of an IPAM pool.
///
/// For more information, see [Modify a
/// pool](https://docs.aws.amazon.com/vpc/latest/ipam/mod-pool-ipam.html) in the
/// *Amazon VPC IPAM User Guide*.
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

    _arena: std.heap.ArenaAllocator = undefined,

    pub fn deinit(self: *ModifyIpamPoolOutput) void {
        self._arena.deinit();
    }
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, input: ModifyIpamPoolInput, options: Options) !ModifyIpamPoolOutput {
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

fn serializeRequest(alloc: std.mem.Allocator, input: ModifyIpamPoolInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpoint("ec2", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var body_buf: std.ArrayList(u8) = .{};

    try body_buf.appendSlice(alloc, "Action=ModifyIpamPool&Version=2016-11-15");
    if (input.add_allocation_resource_tags) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&AddAllocationResourceTags.item.{d}.Key=", .{n}) catch continue;
                try body_buf.appendSlice(alloc, field_prefix);
                if (item.key) |fv_1| {
                    try aws.url.appendUrlEncoded(alloc, &body_buf, fv_1);
                }
            }
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&AddAllocationResourceTags.item.{d}.Value=", .{n}) catch continue;
                try body_buf.appendSlice(alloc, field_prefix);
                if (item.value) |fv_1| {
                    try aws.url.appendUrlEncoded(alloc, &body_buf, fv_1);
                }
            }
        }
    }
    if (input.allocation_default_netmask_length) |v| {
        try body_buf.appendSlice(alloc, "&AllocationDefaultNetmaskLength=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{v}) catch "");
    }
    if (input.allocation_max_netmask_length) |v| {
        try body_buf.appendSlice(alloc, "&AllocationMaxNetmaskLength=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{v}) catch "");
    }
    if (input.allocation_min_netmask_length) |v| {
        try body_buf.appendSlice(alloc, "&AllocationMinNetmaskLength=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{v}) catch "");
    }
    if (input.auto_import) |v| {
        try body_buf.appendSlice(alloc, "&AutoImport=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, if (v) "true" else "false");
    }
    if (input.clear_allocation_default_netmask_length) |v| {
        try body_buf.appendSlice(alloc, "&ClearAllocationDefaultNetmaskLength=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, if (v) "true" else "false");
    }
    if (input.description) |v| {
        try body_buf.appendSlice(alloc, "&Description=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.dry_run) |v| {
        try body_buf.appendSlice(alloc, "&DryRun=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, if (v) "true" else "false");
    }
    try body_buf.appendSlice(alloc, "&IpamPoolId=");
    try aws.url.appendUrlEncoded(alloc, &body_buf, input.ipam_pool_id);
    if (input.remove_allocation_resource_tags) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&RemoveAllocationResourceTags.item.{d}.Key=", .{n}) catch continue;
                try body_buf.appendSlice(alloc, field_prefix);
                if (item.key) |fv_1| {
                    try aws.url.appendUrlEncoded(alloc, &body_buf, fv_1);
                }
            }
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&RemoveAllocationResourceTags.item.{d}.Value=", .{n}) catch continue;
                try body_buf.appendSlice(alloc, field_prefix);
                if (item.value) |fv_1| {
                    try aws.url.appendUrlEncoded(alloc, &body_buf, fv_1);
                }
            }
        }
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

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !ModifyIpamPoolOutput {
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
                    result.ipam_pool = try serde.deserializeIpamPool(&reader, alloc);
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
