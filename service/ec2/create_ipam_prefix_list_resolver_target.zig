const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const TagSpecification = @import("tag_specification.zig").TagSpecification;
const IpamPrefixListResolverTarget = @import("ipam_prefix_list_resolver_target.zig").IpamPrefixListResolverTarget;
const serde = @import("serde.zig");

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
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateIpamPrefixListResolverTargetInput, options: CallOptions) !CreateIpamPrefixListResolverTargetOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateIpamPrefixListResolverTargetInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("ec2", "EC2", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var body_buf: std.ArrayList(u8) = .{};

    try body_buf.appendSlice(allocator, "Action=CreateIpamPrefixListResolverTarget&Version=2016-11-15");
    if (input.client_token) |v| {
        try body_buf.appendSlice(allocator, "&ClientToken=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.desired_version) |v| {
        try body_buf.appendSlice(allocator, "&DesiredVersion=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{v}) catch "");
    }
    if (input.dry_run) |v| {
        try body_buf.appendSlice(allocator, "&DryRun=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, if (v) "true" else "false");
    }
    try body_buf.appendSlice(allocator, "&IpamPrefixListResolverId=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.ipam_prefix_list_resolver_id);
    try body_buf.appendSlice(allocator, "&PrefixListId=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.prefix_list_id);
    try body_buf.appendSlice(allocator, "&PrefixListRegion=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.prefix_list_region);
    if (input.tag_specifications) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            {
                var prefix_buf: [256]u8 = undefined;
                if (item.resource_type) |fv_1| {
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&TagSpecification.{d}.ResourceType=", .{n}) catch continue;
                    try body_buf.appendSlice(allocator, field_prefix);
                    try aws.url.appendUrlEncoded(allocator, &body_buf, fv_1.wireName());
                }
            }
            if (item.tags) |lst_1| {
                for (lst_1, 0..) |item_1, idx_1| {
                    const n_1 = idx_1 + 1;
                    {
                        var prefix_buf: [256]u8 = undefined;
                        if (item_1.key) |fv_2| {
                            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&TagSpecification.{d}.Tag.{d}.Key=", .{n, n_1}) catch continue;
                            try body_buf.appendSlice(allocator, field_prefix);
                            try aws.url.appendUrlEncoded(allocator, &body_buf, fv_2);
                        }
                    }
                    {
                        var prefix_buf: [256]u8 = undefined;
                        if (item_1.value) |fv_2| {
                            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&TagSpecification.{d}.Tag.{d}.Value=", .{n, n_1}) catch continue;
                            try body_buf.appendSlice(allocator, field_prefix);
                            try aws.url.appendUrlEncoded(allocator, &body_buf, fv_2);
                        }
                    }
                }
            }
        }
    }
    try body_buf.appendSlice(allocator, "&TrackLatestVersion=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, if (input.track_latest_version) "true" else "false");

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateIpamPrefixListResolverTargetOutput {
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
                    result.ipam_prefix_list_resolver_target = try serde.deserializeIpamPrefixListResolverTarget(allocator, &reader);
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
