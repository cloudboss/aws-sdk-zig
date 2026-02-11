const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const Filter = @import("filter.zig").Filter;
const AvailabilityZone = @import("availability_zone.zig").AvailabilityZone;

/// Describes the Availability Zones, Local Zones, and Wavelength Zones that are
/// available to
/// you.
///
/// For more information about Availability Zones, Local Zones, and Wavelength
/// Zones, see
/// [Regions and
/// zones](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/using-regions-availability-zones.html)
/// in the *Amazon EC2 User Guide*.
///
/// **Note:**
///
/// The order of the elements in the response, including those within nested
/// structures, might vary. Applications should not assume the elements appear
/// in a
/// particular order.
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

    allocator: std.mem.Allocator,

    pub fn deinit(self: *const DescribeAvailabilityZonesOutput) void {
        _ = self;
    }
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, input: DescribeAvailabilityZonesInput, options: Options) !DescribeAvailabilityZonesOutput {
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

    return try deserializeResponse(response.body, response.status, response.headers, client.allocator);
}

fn serializeRequest(alloc: std.mem.Allocator, input: DescribeAvailabilityZonesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpoint("ec2", alloc);

    const host = parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = parsePort(endpoint);

    var body_buf: std.ArrayList(u8) = .{};

    try body_buf.appendSlice(alloc, "Action=DescribeAvailabilityZones&Version=2016-11-15");
    if (input.all_availability_zones) |v| {
        try body_buf.appendSlice(alloc, "&AllAvailabilityZones=");
        try appendUrlEncoded(alloc, &body_buf, if (v) "true" else "false");
    }
    if (input.dry_run) |v| {
        try body_buf.appendSlice(alloc, "&DryRun=");
        try appendUrlEncoded(alloc, &body_buf, if (v) "true" else "false");
    }
    if (input.filters) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Filters.Filter.{d}.Name=", .{n}) catch continue;
                try body_buf.appendSlice(alloc, field_prefix);
                if (item.name) |v| {
                    try appendUrlEncoded(alloc, &body_buf, v);
                }
            }
        }
    }
    if (input.zone_ids) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            var prefix_buf: [256]u8 = undefined;
            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&ZoneIds.ZoneId.{d}=", .{n}) catch continue;
            try body_buf.appendSlice(alloc, field_prefix);
            try appendUrlEncoded(alloc, &body_buf, item);
        }
    }
    if (input.zone_names) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            var prefix_buf: [256]u8 = undefined;
            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&ZoneNames.ZoneName.{d}=", .{n}) catch continue;
            try body_buf.appendSlice(alloc, field_prefix);
            try appendUrlEncoded(alloc, &body_buf, item);
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
    _ = body;
    const result: DescribeAvailabilityZonesOutput = .{ .allocator = alloc };

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
