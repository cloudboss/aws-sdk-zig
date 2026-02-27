const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const Filter = @import("filter.zig").Filter;
const AvailabilityZone = @import("availability_zone.zig").AvailabilityZone;
const serde = @import("serde.zig");

pub const DescribeAvailabilityZonesInput = struct {
    /// Include all Availability Zones, Local Zones, and Wavelength Zones regardless
    /// of your
    /// opt-in status.
    ///
    /// If you do not use this parameter, the results include only the zones for the
    /// Regions where you have chosen the option to opt in.
    all_availability_zones: ?bool = null,

    /// Checks whether you have the required permissions for the action, without
    /// actually making the request,
    /// and provides an error response. If you have the required permissions, the
    /// error response is `DryRunOperation`.
    /// Otherwise, it is `UnauthorizedOperation`.
    dry_run: ?bool = null,

    /// The filters.
    ///
    /// * `group-long-name` - The long name of the zone group for the Availability
    ///   Zone (for
    /// example, `US West (Oregon) 1`), the Local Zone (for example, for Zone group
    /// `us-west-2-lax-1`, it is `US West (Los Angeles)`,
    /// or the Wavelength Zone (for example, for Zone group `us-east-1-wl1`, it is
    /// `US East (Verizon)`.
    ///
    /// * `group-name` - The name of the zone group for the Availability Zone (for
    /// example, `us-east-1-zg-1`), the Local Zone (for example, `us-west-2-lax-1`),
    /// or the Wavelength Zone (for example, `us-east-1-wl1`).
    ///
    /// * `message` - The Zone message.
    ///
    /// * `opt-in-status` - The opt-in status (`opted-in` |
    /// `not-opted-in` | `opt-in-not-required`).
    ///
    /// * `parent-zone-id` - The ID of the zone that handles some of the Local Zone
    /// and Wavelength Zone control plane operations, such as API calls.
    ///
    /// * `parent-zone-name` - The ID of the zone that handles some of the Local
    ///   Zone
    /// and Wavelength Zone control plane operations, such as API calls.
    ///
    /// * `region-name` - The name of the Region for the Zone (for example,
    /// `us-east-1`).
    ///
    /// * `state` - The state of the Availability Zone, the Local Zone, or the
    /// Wavelength Zone (`available` | `unavailable` |
    /// `constrained`).
    ///
    /// * `zone-id` - The ID of the Availability Zone (for example,
    /// `use1-az1`), the Local Zone (for example, `usw2-lax1-az1`), or the
    /// Wavelength Zone (for example, `us-east-1-wl1-bos-wlz-1`).
    ///
    /// * `zone-name` - The name of the Availability Zone (for example,
    /// `us-east-1a`), the Local Zone (for example, `us-west-2-lax-1a`), or
    /// the Wavelength Zone (for example, `us-east-1-wl1-bos-wlz-1`).
    ///
    /// * `zone-type` - The type of zone (`availability-zone` |
    /// `local-zone` | `wavelength-zone`).
    filters: ?[]const Filter = null,

    /// The IDs of the Availability Zones, Local Zones, and Wavelength Zones.
    zone_ids: ?[]const []const u8 = null,

    /// The names of the Availability Zones, Local Zones, and Wavelength Zones.
    zone_names: ?[]const []const u8 = null,
};

pub const DescribeAvailabilityZonesOutput = struct {
    /// Information about the Availability Zones, Local Zones, and Wavelength Zones.
    availability_zones: ?[]const AvailabilityZone = null,
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeAvailabilityZonesInput, options: Options) !DescribeAvailabilityZonesOutput {
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
            d.* = parseErrorResponse(response.body, response.status, client.allocator) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(response.body, response.status, response.headers, allocator);
    return result;
}

fn serializeRequest(alloc: std.mem.Allocator, input: DescribeAvailabilityZonesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("ec2", "EC2", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var body_buf: std.ArrayList(u8) = .{};

    try body_buf.appendSlice(alloc, "Action=DescribeAvailabilityZones&Version=2016-11-15");
    if (input.all_availability_zones) |v| {
        try body_buf.appendSlice(alloc, "&AllAvailabilityZones=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, if (v) "true" else "false");
    }
    if (input.dry_run) |v| {
        try body_buf.appendSlice(alloc, "&DryRun=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, if (v) "true" else "false");
    }
    if (input.filters) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Filter.Filter.{d}.Name=", .{n}) catch continue;
                try body_buf.appendSlice(alloc, field_prefix);
                if (item.name) |fv_1| {
                    try aws.url.appendUrlEncoded(alloc, &body_buf, fv_1);
                }
            }
            if (item.values) |lst_1| {
                for (lst_1, 0..) |item_1, idx_1| {
                    const n_1 = idx_1 + 1;
                    {
                        var prefix_buf: [256]u8 = undefined;
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Filter.Filter.{d}.Values.item.{d}=", .{ n, n_1 }) catch continue;
                        try body_buf.appendSlice(alloc, field_prefix);
                        try aws.url.appendUrlEncoded(alloc, &body_buf, item_1);
                    }
                }
            }
        }
    }
    if (input.zone_ids) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            var prefix_buf: [256]u8 = undefined;
            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&ZoneId.ZoneId.{d}=", .{n}) catch continue;
            try body_buf.appendSlice(alloc, field_prefix);
            try aws.url.appendUrlEncoded(alloc, &body_buf, item);
        }
    }
    if (input.zone_names) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            var prefix_buf: [256]u8 = undefined;
            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&ZoneName.ZoneName.{d}=", .{n}) catch continue;
            try body_buf.appendSlice(alloc, field_prefix);
            try aws.url.appendUrlEncoded(alloc, &body_buf, item);
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

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !DescribeAvailabilityZonesOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => break,
            else => {},
        }
    }

    var result: DescribeAvailabilityZonesOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "availabilityZoneInfo")) {
                    result.availability_zones = try serde.deserializeAvailabilityZoneList(&reader, alloc, "item");
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
    var arena = std.heap.ArenaAllocator.init(alloc);
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
