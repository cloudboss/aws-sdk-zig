const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const AddIpamOperatingRegion = @import("add_ipam_operating_region.zig").AddIpamOperatingRegion;
const AddIpamOrganizationalUnitExclusion = @import("add_ipam_organizational_unit_exclusion.zig").AddIpamOrganizationalUnitExclusion;
const RemoveIpamOperatingRegion = @import("remove_ipam_operating_region.zig").RemoveIpamOperatingRegion;
const RemoveIpamOrganizationalUnitExclusion = @import("remove_ipam_organizational_unit_exclusion.zig").RemoveIpamOrganizationalUnitExclusion;
const IpamResourceDiscovery = @import("ipam_resource_discovery.zig").IpamResourceDiscovery;

/// Modifies a resource discovery. A resource discovery is an IPAM component
/// that enables IPAM to manage and monitor resources that belong to the owning
/// account.
pub const ModifyIpamResourceDiscoveryInput = struct {
    /// Add operating Regions to the resource discovery. Operating Regions are
    /// Amazon Web Services Regions where the IPAM is allowed to manage IP address
    /// CIDRs. IPAM only discovers and monitors resources in the Amazon Web Services
    /// Regions you select as operating Regions.
    add_operating_regions: ?[]const AddIpamOperatingRegion = null,

    /// Add an Organizational Unit (OU) exclusion to your IPAM. If your IPAM is
    /// integrated with Amazon Web Services Organizations and you add an
    /// organizational unit (OU) exclusion, IPAM will not manage the IP addresses in
    /// accounts in that OU exclusion. There is a limit on the number of exclusions
    /// you can create. For more information, see [Quotas for your
    /// IPAM](https://docs.aws.amazon.com/vpc/latest/ipam/quotas-ipam.html) in the
    /// *Amazon VPC IPAM User Guide*.
    ///
    /// **Note:**
    ///
    /// The resulting set of exclusions must not result in "overlap", meaning two or
    /// more OU
    /// exclusions must not exclude the same OU. For more information and examples,
    /// see the Amazon Web Services CLI request process in [Add or remove OU
    /// exclusions
    /// ](https://docs.aws.amazon.com/vpc/latest/ipam/exclude-ous.html#exclude-ous-create-delete) in the *Amazon VPC User Guide*.
    add_organizational_unit_exclusions: ?[]const AddIpamOrganizationalUnitExclusion = null,

    /// A resource discovery description.
    description: ?[]const u8 = null,

    /// A check for whether you have the required permissions for the action without
    /// actually making the request
    /// and provides an error response. If you have the required permissions, the
    /// error response is `DryRunOperation`.
    /// Otherwise, it is `UnauthorizedOperation`.
    dry_run: ?bool = null,

    /// A resource discovery ID.
    ipam_resource_discovery_id: []const u8,

    /// Remove operating Regions.
    remove_operating_regions: ?[]const RemoveIpamOperatingRegion = null,

    /// Remove an Organizational Unit (OU) exclusion to your IPAM. If your IPAM is
    /// integrated with Amazon Web Services Organizations and you add an
    /// organizational unit (OU) exclusion, IPAM will not manage the IP addresses in
    /// accounts in that OU exclusion. There is a limit on the number of exclusions
    /// you can create. For more information, see [Quotas for your
    /// IPAM](https://docs.aws.amazon.com/vpc/latest/ipam/quotas-ipam.html) in the
    /// *Amazon VPC IPAM User Guide*.
    ///
    /// **Note:**
    ///
    /// The resulting set of exclusions must not result in "overlap", meaning two or
    /// more OU
    /// exclusions must not exclude the same OU. For more information and examples,
    /// see the Amazon Web Services CLI request process in [Add or remove OU
    /// exclusions
    /// ](https://docs.aws.amazon.com/vpc/latest/ipam/exclude-ous.html#exclude-ous-create-delete) in the *Amazon VPC User Guide*.
    remove_organizational_unit_exclusions: ?[]const RemoveIpamOrganizationalUnitExclusion = null,
};

pub const ModifyIpamResourceDiscoveryOutput = struct {
    /// A resource discovery.
    ipam_resource_discovery: ?IpamResourceDiscovery = null,

    allocator: std.mem.Allocator,

    pub fn deinit(self: *const ModifyIpamResourceDiscoveryOutput) void {
        _ = self;
    }
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, input: ModifyIpamResourceDiscoveryInput, options: Options) !ModifyIpamResourceDiscoveryOutput {
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

fn serializeRequest(alloc: std.mem.Allocator, input: ModifyIpamResourceDiscoveryInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpoint("ec2", alloc);

    const host = parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = parsePort(endpoint);

    var body_buf: std.ArrayList(u8) = .{};

    try body_buf.appendSlice(alloc, "Action=ModifyIpamResourceDiscovery&Version=2016-11-15");
    if (input.add_operating_regions) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&AddOperatingRegions.member.{d}.RegionName=", .{n}) catch continue;
                try body_buf.appendSlice(alloc, field_prefix);
                if (item.region_name) |v| {
                    try appendUrlEncoded(alloc, &body_buf, v);
                }
            }
        }
    }
    if (input.add_organizational_unit_exclusions) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&AddOrganizationalUnitExclusions.member.{d}.OrganizationsEntityPath=", .{n}) catch continue;
                try body_buf.appendSlice(alloc, field_prefix);
                if (item.organizations_entity_path) |v| {
                    try appendUrlEncoded(alloc, &body_buf, v);
                }
            }
        }
    }
    if (input.description) |v| {
        try body_buf.appendSlice(alloc, "&Description=");
        try appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.dry_run) |v| {
        try body_buf.appendSlice(alloc, "&DryRun=");
        try appendUrlEncoded(alloc, &body_buf, if (v) "true" else "false");
    }
    try body_buf.appendSlice(alloc, "&IpamResourceDiscoveryId=");
    try appendUrlEncoded(alloc, &body_buf, input.ipam_resource_discovery_id);
    if (input.remove_operating_regions) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&RemoveOperatingRegions.member.{d}.RegionName=", .{n}) catch continue;
                try body_buf.appendSlice(alloc, field_prefix);
                if (item.region_name) |v| {
                    try appendUrlEncoded(alloc, &body_buf, v);
                }
            }
        }
    }
    if (input.remove_organizational_unit_exclusions) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&RemoveOrganizationalUnitExclusions.member.{d}.OrganizationsEntityPath=", .{n}) catch continue;
                try body_buf.appendSlice(alloc, field_prefix);
                if (item.organizations_entity_path) |v| {
                    try appendUrlEncoded(alloc, &body_buf, v);
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

fn deserializeResponse(body: []const u8, status: u16, alloc: std.mem.Allocator) !ModifyIpamResourceDiscoveryOutput {
    _ = status;
    _ = body;
    const result: ModifyIpamResourceDiscoveryOutput = .{ .allocator = alloc };

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
