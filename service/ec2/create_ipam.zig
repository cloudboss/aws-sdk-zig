const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const IpamMeteredAccount = @import("ipam_metered_account.zig").IpamMeteredAccount;
const AddIpamOperatingRegion = @import("add_ipam_operating_region.zig").AddIpamOperatingRegion;
const TagSpecification = @import("tag_specification.zig").TagSpecification;
const IpamTier = @import("ipam_tier.zig").IpamTier;
const Ipam = @import("ipam.zig").Ipam;

/// Create an IPAM. Amazon VPC IP Address Manager (IPAM) is a VPC feature that
/// you can use
/// to automate your IP address management workflows including assigning,
/// tracking,
/// troubleshooting, and auditing IP addresses across Amazon Web Services
/// Regions and accounts
/// throughout your Amazon Web Services Organization.
///
/// For more information, see [Create an
/// IPAM](https://docs.aws.amazon.com/vpc/latest/ipam/create-ipam.html) in the
/// *Amazon VPC IPAM User Guide*.
pub const CreateIpamInput = struct {
    /// A unique, case-sensitive identifier that you provide to ensure the
    /// idempotency of the request. For more information, see [Ensuring
    /// idempotency](https://docs.aws.amazon.com/ec2/latest/devguide/ec2-api-idempotency.html).
    client_token: ?[]const u8 = null,

    /// A description for the IPAM.
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

    /// The operating Regions for the IPAM. Operating Regions are Amazon Web
    /// Services Regions where the IPAM is allowed to manage IP address CIDRs. IPAM
    /// only discovers and monitors resources in the Amazon Web Services Regions you
    /// select as operating Regions.
    ///
    /// For more information about operating Regions, see [Create an
    /// IPAM](https://docs.aws.amazon.com/vpc/latest/ipam/create-ipam.html) in the
    /// *Amazon VPC IPAM User Guide*.
    operating_regions: ?[]const AddIpamOperatingRegion = null,

    /// The key/value combination of a tag assigned to the resource. Use the tag key
    /// in the filter name and the tag value as the filter value.
    /// For example, to find all resources that have a tag with the key `Owner` and
    /// the value `TeamA`, specify `tag:Owner` for the filter name and `TeamA` for
    /// the filter value.
    tag_specifications: ?[]const TagSpecification = null,

    /// IPAM is offered in a Free Tier and an Advanced Tier. For more information
    /// about the features available in each tier and the costs associated with the
    /// tiers, see [Amazon VPC pricing > IPAM
    /// tab](http://aws.amazon.com/vpc/pricing/).
    tier: ?IpamTier = null,
};

pub const CreateIpamOutput = struct {
    /// Information about the IPAM created.
    ipam: ?Ipam = null,

    allocator: std.mem.Allocator,

    pub fn deinit(self: *const CreateIpamOutput) void {
        _ = self;
    }
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, input: CreateIpamInput, options: Options) !CreateIpamOutput {
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

    return try deserializeResponse(response.body, response.status, client.allocator);
}

fn serializeRequest(alloc: std.mem.Allocator, input: CreateIpamInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpoint("ec2", alloc);

    const host = parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = parsePort(endpoint);

    var body_buf: std.ArrayList(u8) = .{};

    try body_buf.appendSlice(alloc, "Action=CreateIpam&Version=2016-11-15");
    if (input.client_token) |v| {
        try body_buf.appendSlice(alloc, "&ClientToken=");
        try appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.description) |v| {
        try body_buf.appendSlice(alloc, "&Description=");
        try appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.dry_run) |v| {
        try body_buf.appendSlice(alloc, "&DryRun=");
        try appendUrlEncoded(alloc, &body_buf, if (v) "true" else "false");
    }
    if (input.enable_private_gua) |v| {
        try body_buf.appendSlice(alloc, "&EnablePrivateGua=");
        try appendUrlEncoded(alloc, &body_buf, if (v) "true" else "false");
    }
    if (input.metered_account) |v| {
        try body_buf.appendSlice(alloc, "&MeteredAccount=");
        try appendUrlEncoded(alloc, &body_buf, @tagName(v));
    }
    if (input.operating_regions) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&OperatingRegions.member.{d}.RegionName=", .{n}) catch continue;
                try body_buf.appendSlice(alloc, field_prefix);
                if (item.region_name) |v| {
                    try appendUrlEncoded(alloc, &body_buf, v);
                }
            }
        }
    }
    if (input.tag_specifications) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&TagSpecifications.item.{d}.ResourceType=", .{n}) catch continue;
                try body_buf.appendSlice(alloc, field_prefix);
                if (item.resource_type) |v| {
                    try appendUrlEncoded(alloc, &body_buf, @tagName(v));
                }
            }
        }
    }
    if (input.tier) |v| {
        try body_buf.appendSlice(alloc, "&Tier=");
        try appendUrlEncoded(alloc, &body_buf, @tagName(v));
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

fn deserializeResponse(body: []const u8, status: u16, alloc: std.mem.Allocator) !CreateIpamOutput {
    _ = status;
    _ = body;
    const result: CreateIpamOutput = .{ .allocator = alloc };

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
