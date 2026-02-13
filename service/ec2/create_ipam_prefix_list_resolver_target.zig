const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const TagSpecification = @import("tag_specification.zig").TagSpecification;
const IpamPrefixListResolverTarget = @import("ipam_prefix_list_resolver_target.zig").IpamPrefixListResolverTarget;
const serde = @import("serde.zig");

/// Creates an IPAM prefix list resolver target.
///
/// An IPAM prefix list resolver target is an association between a specific
/// customer-managed prefix list and an IPAM prefix list resolver. The target
/// enables the resolver to synchronize CIDRs selected by its rules into the
/// specified prefix list, which can then be referenced in Amazon Web Services
/// resources.
///
/// For more information about IPAM prefix list resolver, see [Automate prefix
/// list updates with
/// IPAM](https://docs.aws.amazon.com/vpc/latest/ipam/automate-prefix-list-updates.html) in the *Amazon VPC IPAM User Guide*.
pub const CreateIpamPrefixListResolverTargetInput = struct {
    /// A unique, case-sensitive identifier that you provide to ensure the
    /// idempotency of the request. For more information, see [Ensuring
    /// idempotency](https://docs.aws.amazon.com/ec2/latest/devguide/ec2-api-idempotency.html).
    client_token: ?[]const u8 = null,

    /// The specific version of the prefix list to target. If not specified, the
    /// resolver will target the latest version.
    desired_version: ?i64 = null,

    /// A check for whether you have the required permissions for the action without
    /// actually making the request
    /// and provides an error response. If you have the required permissions, the
    /// error response is `DryRunOperation`.
    /// Otherwise, it is `UnauthorizedOperation`.
    dry_run: ?bool = null,

    /// The ID of the IPAM prefix list resolver that will manage the synchronization
    /// of CIDRs to the target prefix list.
    ipam_prefix_list_resolver_id: []const u8,

    /// The ID of the managed prefix list that will be synchronized with CIDRs
    /// selected by the IPAM prefix list resolver. This prefix list becomes an IPAM
    /// managed prefix list.
    ///
    /// An IPAM-managed prefix list is a customer-managed prefix list that has been
    /// associated with an IPAM prefix list resolver target. When a prefix list
    /// becomes IPAM managed, its CIDRs are automatically synchronized based on the
    /// IPAM prefix list resolver's CIDR selection rules, and direct CIDR
    /// modifications are restricted.
    prefix_list_id: []const u8,

    /// The Amazon Web Services Region where the prefix list is located. This is
    /// required when referencing a prefix list in a different Region.
    prefix_list_region: []const u8,

    /// The tags to apply to the IPAM prefix list resolver target during creation.
    /// Tags help you organize and manage your Amazon Web Services resources.
    tag_specifications: ?[]const TagSpecification = null,

    /// Indicates whether the resolver target should automatically track the latest
    /// version of the prefix list. When enabled, the target will always synchronize
    /// with the most current version of the prefix list.
    ///
    /// Choose this for automatic updates when you want your prefix lists to stay
    /// current with infrastructure changes without manual intervention.
    track_latest_version: bool,
};

pub const CreateIpamPrefixListResolverTargetOutput = struct {
    /// Information about the IPAM prefix list resolver target that was created.
    ipam_prefix_list_resolver_target: ?IpamPrefixListResolverTarget = null,

    _arena: std.heap.ArenaAllocator = undefined,

    pub fn deinit(self: *CreateIpamPrefixListResolverTargetOutput) void {
        self._arena.deinit();
    }
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, input: CreateIpamPrefixListResolverTargetInput, options: Options) !CreateIpamPrefixListResolverTargetOutput {
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

fn serializeRequest(alloc: std.mem.Allocator, input: CreateIpamPrefixListResolverTargetInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpoint("ec2", alloc);

    const host = parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = parsePort(endpoint);

    var body_buf: std.ArrayList(u8) = .{};

    try body_buf.appendSlice(alloc, "Action=CreateIpamPrefixListResolverTarget&Version=2016-11-15");
    if (input.client_token) |v| {
        try body_buf.appendSlice(alloc, "&ClientToken=");
        try appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.desired_version) |v| {
        try body_buf.appendSlice(alloc, "&DesiredVersion=");
        try appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{v}) catch "");
    }
    if (input.dry_run) |v| {
        try body_buf.appendSlice(alloc, "&DryRun=");
        try appendUrlEncoded(alloc, &body_buf, if (v) "true" else "false");
    }
    try body_buf.appendSlice(alloc, "&IpamPrefixListResolverId=");
    try appendUrlEncoded(alloc, &body_buf, input.ipam_prefix_list_resolver_id);
    try body_buf.appendSlice(alloc, "&PrefixListId=");
    try appendUrlEncoded(alloc, &body_buf, input.prefix_list_id);
    try body_buf.appendSlice(alloc, "&PrefixListRegion=");
    try appendUrlEncoded(alloc, &body_buf, input.prefix_list_region);
    if (input.tag_specifications) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&TagSpecifications.item.{d}.ResourceType=", .{n}) catch continue;
                try body_buf.appendSlice(alloc, field_prefix);
                if (item.resource_type) |fv_1| {
                    try appendUrlEncoded(alloc, &body_buf, @tagName(fv_1));
                }
            }
            if (item.tags) |lst_1| {
                for (lst_1, 0..) |item_1, idx_1| {
                    const n_1 = idx_1 + 1;
                    {
                        var prefix_buf: [256]u8 = undefined;
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&TagSpecifications.item.{d}.Tags.item.{d}.Key=", .{n, n_1}) catch continue;
                        try body_buf.appendSlice(alloc, field_prefix);
                        if (item_1.key) |fv_2| {
                            try appendUrlEncoded(alloc, &body_buf, fv_2);
                        }
                    }
                    {
                        var prefix_buf: [256]u8 = undefined;
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&TagSpecifications.item.{d}.Tags.item.{d}.Value=", .{n, n_1}) catch continue;
                        try body_buf.appendSlice(alloc, field_prefix);
                        if (item_1.value) |fv_2| {
                            try appendUrlEncoded(alloc, &body_buf, fv_2);
                        }
                    }
                }
            }
        }
    }
    try body_buf.appendSlice(alloc, "&TrackLatestVersion=");
    try appendUrlEncoded(alloc, &body_buf, if (input.track_latest_version) "true" else "false");

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

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !CreateIpamPrefixListResolverTargetOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => break,
            else => {},
        }
    }

    var result: CreateIpamPrefixListResolverTargetOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "ipamPrefixListResolverTarget")) {
                    result.ipam_prefix_list_resolver_target = try serde.deserializeIpamPrefixListResolverTarget(&reader, alloc);
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
