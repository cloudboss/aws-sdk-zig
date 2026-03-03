const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const AddIpamOperatingRegion = @import("add_ipam_operating_region.zig").AddIpamOperatingRegion;
const AddIpamOrganizationalUnitExclusion = @import("add_ipam_organizational_unit_exclusion.zig").AddIpamOrganizationalUnitExclusion;
const RemoveIpamOperatingRegion = @import("remove_ipam_operating_region.zig").RemoveIpamOperatingRegion;
const RemoveIpamOrganizationalUnitExclusion = @import("remove_ipam_organizational_unit_exclusion.zig").RemoveIpamOrganizationalUnitExclusion;
const IpamResourceDiscovery = @import("ipam_resource_discovery.zig").IpamResourceDiscovery;
const serde = @import("serde.zig");

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
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ModifyIpamResourceDiscoveryInput, options: Options) !ModifyIpamResourceDiscoveryOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ModifyIpamResourceDiscoveryInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("ec2", "EC2", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var body_buf: std.ArrayList(u8) = .{};

    try body_buf.appendSlice(allocator, "Action=ModifyIpamResourceDiscovery&Version=2016-11-15");
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
    if (input.add_organizational_unit_exclusions) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&AddOrganizationalUnitExclusion.member.{d}.OrganizationsEntityPath=", .{n}) catch continue;
                try body_buf.appendSlice(allocator, field_prefix);
                if (item.organizations_entity_path) |fv_1| {
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
    try body_buf.appendSlice(allocator, "&IpamResourceDiscoveryId=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.ipam_resource_discovery_id);
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
    if (input.remove_organizational_unit_exclusions) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&RemoveOrganizationalUnitExclusion.member.{d}.OrganizationsEntityPath=", .{n}) catch continue;
                try body_buf.appendSlice(allocator, field_prefix);
                if (item.organizations_entity_path) |fv_1| {
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ModifyIpamResourceDiscoveryOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => break,
            else => {},
        }
    }

    var result: ModifyIpamResourceDiscoveryOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "ipamResourceDiscovery")) {
                    result.ipam_resource_discovery = try serde.deserializeIpamResourceDiscovery(allocator, &reader);
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
