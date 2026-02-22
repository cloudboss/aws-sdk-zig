const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const CidrAuthorizationContext = @import("cidr_authorization_context.zig").CidrAuthorizationContext;
const TagSpecification = @import("tag_specification.zig").TagSpecification;
const ByoipCidr = @import("byoip_cidr.zig").ByoipCidr;
const serde = @import("serde.zig");

pub const ProvisionByoipCidrInput = struct {
    /// The public IPv4 or IPv6 address range, in CIDR notation. The most specific
    /// IPv4 prefix that you can
    /// specify is /24. The most specific IPv6 address range that you can bring is
    /// /48 for CIDRs that are publicly advertisable and /56 for CIDRs that are not
    /// publicly advertisable. The address range cannot overlap with another address
    /// range that you've
    /// brought to this or another Region.
    cidr: []const u8,

    /// A signed document that proves that you are authorized to bring the specified
    /// IP address
    /// range to Amazon using BYOIP.
    cidr_authorization_context: ?CidrAuthorizationContext = null,

    /// A description for the address range and the address pool.
    description: ?[]const u8 = null,

    /// Checks whether you have the required permissions for the action, without
    /// actually making the request,
    /// and provides an error response. If you have the required permissions, the
    /// error response is `DryRunOperation`.
    /// Otherwise, it is `UnauthorizedOperation`.
    dry_run: ?bool = null,

    /// Reserved.
    multi_region: ?bool = null,

    /// If you have [Local
    /// Zones](https://docs.aws.amazon.com/local-zones/latest/ug/how-local-zones-work.html) enabled, you can choose a network border group for Local Zones when you provision and advertise a BYOIPv4 CIDR. Choose the network border group carefully as the EIP and the Amazon Web Services resource it is associated with must reside in the same network border group.
    ///
    /// You can provision BYOIP address ranges to and advertise them in the
    /// following Local Zone network border groups:
    ///
    /// * us-east-1-dfw-2
    ///
    /// * us-west-2-lax-1
    ///
    /// * us-west-2-phx-2
    ///
    /// You cannot provision or advertise BYOIPv6 address ranges in Local Zones at
    /// this time.
    network_border_group: ?[]const u8 = null,

    /// The tags to apply to the address pool.
    pool_tag_specifications: ?[]const TagSpecification = null,

    /// (IPv6 only) Indicate whether the address range will be publicly advertised
    /// to the
    /// internet.
    ///
    /// Default: true
    publicly_advertisable: ?bool = null,
};

pub const ProvisionByoipCidrOutput = struct {
    /// Information about the address range.
    byoip_cidr: ?ByoipCidr = null,

    _arena: std.heap.ArenaAllocator = undefined,

    pub fn deinit(self: *ProvisionByoipCidrOutput) void {
        self._arena.deinit();
    }
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, input: ProvisionByoipCidrInput, options: Options) !ProvisionByoipCidrOutput {
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
            d.* = parseErrorResponse(response.body, response.status, client.allocator) catch .{ .unknown = .{ .http_status = @intCast(response.status) } };
        }
        return error.ServiceError;
    }

    var resp_arena = std.heap.ArenaAllocator.init(client.allocator);
    errdefer resp_arena.deinit();
    var result = try deserializeResponse(response.body, response.status, response.headers, resp_arena.allocator());
    result._arena = resp_arena;
    return result;
}

fn serializeRequest(alloc: std.mem.Allocator, input: ProvisionByoipCidrInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("ec2", "EC2", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var body_buf: std.ArrayList(u8) = .{};

    try body_buf.appendSlice(alloc, "Action=ProvisionByoipCidr&Version=2016-11-15");
    try body_buf.appendSlice(alloc, "&Cidr=");
    try aws.url.appendUrlEncoded(alloc, &body_buf, input.cidr);
    if (input.cidr_authorization_context) |v| {
        try body_buf.appendSlice(alloc, "&CidrAuthorizationContext.Message=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, v.message);
        try body_buf.appendSlice(alloc, "&CidrAuthorizationContext.Signature=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, v.signature);
    }
    if (input.description) |v| {
        try body_buf.appendSlice(alloc, "&Description=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.dry_run) |v| {
        try body_buf.appendSlice(alloc, "&DryRun=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, if (v) "true" else "false");
    }
    if (input.multi_region) |v| {
        try body_buf.appendSlice(alloc, "&MultiRegion=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, if (v) "true" else "false");
    }
    if (input.network_border_group) |v| {
        try body_buf.appendSlice(alloc, "&NetworkBorderGroup=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.pool_tag_specifications) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&PoolTagSpecification.item.{d}.ResourceType=", .{n}) catch continue;
                try body_buf.appendSlice(alloc, field_prefix);
                if (item.resource_type) |fv_1| {
                    try aws.url.appendUrlEncoded(alloc, &body_buf, @tagName(fv_1));
                }
            }
            if (item.tags) |lst_1| {
                for (lst_1, 0..) |item_1, idx_1| {
                    const n_1 = idx_1 + 1;
                    {
                        var prefix_buf: [256]u8 = undefined;
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&PoolTagSpecification.item.{d}.Tags.item.{d}.Key=", .{n, n_1}) catch continue;
                        try body_buf.appendSlice(alloc, field_prefix);
                        if (item_1.key) |fv_2| {
                            try aws.url.appendUrlEncoded(alloc, &body_buf, fv_2);
                        }
                    }
                    {
                        var prefix_buf: [256]u8 = undefined;
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&PoolTagSpecification.item.{d}.Tags.item.{d}.Value=", .{n, n_1}) catch continue;
                        try body_buf.appendSlice(alloc, field_prefix);
                        if (item_1.value) |fv_2| {
                            try aws.url.appendUrlEncoded(alloc, &body_buf, fv_2);
                        }
                    }
                }
            }
        }
    }
    if (input.publicly_advertisable) |v| {
        try body_buf.appendSlice(alloc, "&PubliclyAdvertisable=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, if (v) "true" else "false");
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

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !ProvisionByoipCidrOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => break,
            else => {},
        }
    }

    var result: ProvisionByoipCidrOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "byoipCidr")) {
                    result.byoip_cidr = try serde.deserializeByoipCidr(&reader, alloc);
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

fn parseErrorResponse(body: []const u8, status: u16, alloc: std.mem.Allocator) !ServiceError {
    const error_code = aws.xml.findElement(body, "Code") orelse "Unknown";
    const error_message = aws.xml.findElement(body, "Message") orelse "";
    const request_id = aws.xml.findElement(body, "RequestID") orelse "";
    const owned_message = try alloc.dupe(u8, error_message);
    errdefer alloc.free(owned_message);
    const owned_request_id = try alloc.dupe(u8, request_id);
    errdefer alloc.free(owned_request_id);


    const owned_code = try alloc.dupe(u8, error_code);
    return .{ .unknown = .{
        .code = owned_code,
        .message = owned_message,
        .request_id = owned_request_id,
        .http_status = status,
        ._allocator = alloc,
    } };
}
