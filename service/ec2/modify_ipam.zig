const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const AddIpamOperatingRegion = @import("add_ipam_operating_region.zig").AddIpamOperatingRegion;
const IpamMeteredAccount = @import("ipam_metered_account.zig").IpamMeteredAccount;
const RemoveIpamOperatingRegion = @import("remove_ipam_operating_region.zig").RemoveIpamOperatingRegion;
const IpamTier = @import("ipam_tier.zig").IpamTier;
const Ipam = @import("ipam.zig").Ipam;
const serde = @import("serde.zig");

pub const ModifyIpamInput = struct {
    /// Choose the operating Regions for the IPAM. Operating Regions are Amazon Web
    /// Services Regions where the IPAM is allowed to manage IP address CIDRs. IPAM
    /// only discovers and monitors resources in the Amazon Web Services Regions you
    /// select as operating Regions.
    ///
    /// For more information about operating Regions, see [Create an
    /// IPAM](https://docs.aws.amazon.com/vpc/latest/ipam/create-ipam.html) in the
    /// *Amazon VPC IPAM User Guide*.
    add_operating_regions: ?[]const AddIpamOperatingRegion = null,

    /// The description of the IPAM you want to modify.
    description: ?[]const u8 = null,

    /// A check for whether you have the required permissions for the action without
    /// actually making the request
    /// and provides an error response. If you have the required permissions, the
    /// error response is `DryRunOperation`.
    /// Otherwise, it is `UnauthorizedOperation`.
    dry_run: ?bool = null,

    /// Enable this option to use your own GUA ranges as private IPv6 addresses.
    /// This option is disabled by default.
    enable_private_gua: ?bool = null,

    /// The ID of the IPAM you want to modify.
    ipam_id: []const u8,

    /// A metered account is an Amazon Web Services account that is charged for
    /// active IP addresses managed in IPAM. For more information, see [Enable cost
    /// distribution](https://docs.aws.amazon.com/vpc/latest/ipam/ipam-enable-cost-distro.html) in the *Amazon VPC IPAM User Guide*.
    ///
    /// Possible values:
    ///
    /// * `ipam-owner` (default): The Amazon Web Services account which owns the
    ///   IPAM is charged for all active IP addresses managed in IPAM.
    ///
    /// * `resource-owner`: The Amazon Web Services account that owns the IP address
    ///   is charged for the active IP address.
    metered_account: ?IpamMeteredAccount = null,

    /// The operating Regions to remove.
    remove_operating_regions: ?[]const RemoveIpamOperatingRegion = null,

    /// IPAM is offered in a Free Tier and an Advanced Tier. For more information
    /// about the features available in each tier and the costs associated with the
    /// tiers, see [Amazon VPC pricing > IPAM
    /// tab](http://aws.amazon.com/vpc/pricing/).
    tier: ?IpamTier = null,
};

pub const ModifyIpamOutput = struct {
    /// The results of the modification.
    ipam: ?Ipam = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ModifyIpamInput, options: CallOptions) !ModifyIpamOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ModifyIpamInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("ec2", "EC2", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var body_buf: std.ArrayList(u8) = .{};

    try body_buf.appendSlice(allocator, "Action=ModifyIpam&Version=2016-11-15");
    if (input.add_operating_regions) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&AddOperatingRegion.member.{d}.RegionName=", .{n}) catch continue;
                try body_buf.appendSlice(allocator, field_prefix);
                if (item.region_name) |fv_1| {
                    try aws.url.appendUrlEncoded(allocator, &body_buf, fv_1);
                }
            }
        }
    }
    if (input.description) |v| {
        try body_buf.appendSlice(allocator, "&Description=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.dry_run) |v| {
        try body_buf.appendSlice(allocator, "&DryRun=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, if (v) "true" else "false");
    }
    if (input.enable_private_gua) |v| {
        try body_buf.appendSlice(allocator, "&EnablePrivateGua=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, if (v) "true" else "false");
    }
    try body_buf.appendSlice(allocator, "&IpamId=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.ipam_id);
    if (input.metered_account) |v| {
        try body_buf.appendSlice(allocator, "&MeteredAccount=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, @tagName(v));
    }
    if (input.remove_operating_regions) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&RemoveOperatingRegion.member.{d}.RegionName=", .{n}) catch continue;
                try body_buf.appendSlice(allocator, field_prefix);
                if (item.region_name) |fv_1| {
                    try aws.url.appendUrlEncoded(allocator, &body_buf, fv_1);
                }
            }
        }
    }
    if (input.tier) |v| {
        try body_buf.appendSlice(allocator, "&Tier=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, @tagName(v));
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ModifyIpamOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => break,
            else => {},
        }
    }

    var result: ModifyIpamOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "ipam")) {
                    result.ipam = try serde.deserializeIpam(allocator, &reader);
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
