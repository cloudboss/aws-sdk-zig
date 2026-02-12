const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const Filter = @import("filter.zig").Filter;
const VolumeStatusItem = @import("volume_status_item.zig").VolumeStatusItem;
const serde = @import("serde.zig");

/// Describes the status of the specified volumes. Volume status provides the
/// result of the
/// checks performed on your volumes to determine events that can impair the
/// performance of your
/// volumes. The performance of a volume can be affected if an issue occurs on
/// the volume's
/// underlying host. If the volume's underlying host experiences a power outage
/// or system issue,
/// after the system is restored, there could be data inconsistencies on the
/// volume. Volume events
/// notify you if this occurs. Volume actions notify you if any action needs to
/// be taken in
/// response to the event.
///
/// The `DescribeVolumeStatus` operation provides the following information
/// about
/// the specified volumes:
///
/// *Status*: Reflects the current status of the volume. The possible
/// values are `ok`, `impaired` , `warning`, or
/// `insufficient-data`. If all checks pass, the overall status of the volume is
/// `ok`. If the check fails, the overall status is `impaired`. If the
/// status is `insufficient-data`, then the checks might still be taking place
/// on your
/// volume at the time. We recommend that you retry the request. For more
/// information about volume
/// status, see [Monitor the status of your
/// volumes](https://docs.aws.amazon.com/ebs/latest/userguide/monitoring-volume-status.html) in the *Amazon EBS User Guide*.
///
/// *Events*: Reflect the cause of a volume status and might require you to
/// take action. For example, if your volume returns an `impaired` status, then
/// the
/// volume event might be `potential-data-inconsistency`. This means that your
/// volume
/// has been affected by an issue with the underlying host, has all I/O
/// operations disabled, and
/// might have inconsistent data.
///
/// *Actions*: Reflect the actions you might have to take in response to an
/// event. For example, if the status of the volume is `impaired` and the volume
/// event
/// shows `potential-data-inconsistency`, then the action shows
/// `enable-volume-io`. This means that you may want to enable the I/O
/// operations for
/// the volume and then check the volume for data consistency. For more
/// information, see
/// [Work with an
/// impaired EBS
/// volume](https://docs.aws.amazon.com/ebs/latest/userguide/work_volumes_impaired.html).
///
/// Volume status is based on the volume status checks, and does not reflect the
/// volume state.
/// Therefore, volume status does not indicate volumes in the `error` state (for
/// example, when a volume is incapable of accepting I/O.)
///
/// **Note:**
///
/// The order of the elements in the response, including those within nested
/// structures, might vary. Applications should not assume the elements appear
/// in a
/// particular order.
pub const DescribeVolumeStatusInput = struct {
    /// Checks whether you have the required permissions for the action, without
    /// actually making the request,
    /// and provides an error response. If you have the required permissions, the
    /// error response is `DryRunOperation`.
    /// Otherwise, it is `UnauthorizedOperation`.
    dry_run: ?bool = null,

    /// The filters.
    ///
    /// * `action.code` - The action code for the event (for example,
    /// `enable-volume-io`).
    ///
    /// * `action.description` - A description of the action.
    ///
    /// * `action.event-id` - The event ID associated with the action.
    ///
    /// * `availability-zone` - The Availability Zone of the instance.
    ///
    /// * `event.description` - A description of the event.
    ///
    /// * `event.event-id` - The event ID.
    ///
    /// * `event.event-type` - The event type (for `io-enabled`:
    /// `passed` | `failed`; for `io-performance`:
    /// `io-performance:degraded` | `io-performance:severely-degraded` |
    /// `io-performance:stalled`).
    ///
    /// * `event.not-after` - The latest end time for the event.
    ///
    /// * `event.not-before` - The earliest start time for the event.
    ///
    /// * `volume-status.details-name` - The cause for
    /// `volume-status.status` (`io-enabled` |
    /// `io-performance`).
    ///
    /// * `volume-status.details-status` - The status of
    /// `volume-status.details-name` (for `io-enabled`:
    /// `passed` | `failed`; for `io-performance`:
    /// `normal` | `degraded` | `severely-degraded` |
    /// `stalled`).
    ///
    /// * `volume-status.status` - The status of the volume (`ok` |
    /// `impaired` | `warning` | `insufficient-data`).
    filters: ?[]const Filter = null,

    /// The maximum number of items to return for this request.
    /// To get the next page of items, make another request with the token returned
    /// in the output.
    /// For more information, see
    /// [Pagination](https://docs.aws.amazon.com/AWSEC2/latest/APIReference/Query-Requests.html#api-pagination).
    max_results: ?i32 = null,

    /// The token returned from a previous paginated request.
    /// Pagination continues from the end of the items returned by the previous
    /// request.
    next_token: ?[]const u8 = null,

    /// The IDs of the volumes.
    ///
    /// Default: Describes all your volumes.
    volume_ids: ?[]const []const u8 = null,
};

pub const DescribeVolumeStatusOutput = struct {
    /// The token to include in another request to get the next page of items.
    /// This value is `null` when there are no more items to return.
    next_token: ?[]const u8 = null,

    /// Information about the status of the volumes.
    volume_statuses: ?[]const VolumeStatusItem = null,

    _arena: std.heap.ArenaAllocator = undefined,

    pub fn deinit(self: *DescribeVolumeStatusOutput) void {
        self._arena.deinit();
    }
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, input: DescribeVolumeStatusInput, options: Options) !DescribeVolumeStatusOutput {
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

fn serializeRequest(alloc: std.mem.Allocator, input: DescribeVolumeStatusInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpoint("ec2", alloc);

    const host = parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = parsePort(endpoint);

    var body_buf: std.ArrayList(u8) = .{};

    try body_buf.appendSlice(alloc, "Action=DescribeVolumeStatus&Version=2016-11-15");
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
    if (input.max_results) |v| {
        try body_buf.appendSlice(alloc, "&MaxResults=");
        try appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{v}) catch "");
    }
    if (input.next_token) |v| {
        try body_buf.appendSlice(alloc, "&NextToken=");
        try appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.volume_ids) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            var prefix_buf: [256]u8 = undefined;
            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&VolumeIds.VolumeId.{d}=", .{n}) catch continue;
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

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !DescribeVolumeStatusOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => break,
            else => {},
        }
    }

    var result: DescribeVolumeStatusOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "nextToken")) {
                    result.next_token = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "volumeStatusSet")) {
                    result.volume_statuses = try serde.deserializeVolumeStatusList(&reader, alloc, "item");
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
