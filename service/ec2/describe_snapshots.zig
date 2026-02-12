const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const Filter = @import("filter.zig").Filter;
const Snapshot = @import("snapshot.zig").Snapshot;
const serde = @import("serde.zig");

/// Describes the specified EBS snapshots available to you or all of the EBS
/// snapshots
/// available to you.
///
/// The snapshots available to you include public snapshots, private snapshots
/// that you own,
/// and private snapshots owned by other Amazon Web Services accounts for which
/// you have explicit create volume
/// permissions.
///
/// The create volume permissions fall into the following categories:
///
/// * *public*: The owner of the snapshot granted create volume
/// permissions for the snapshot to the `all` group. All Amazon Web Services
/// accounts have create
/// volume permissions for these snapshots.
///
/// * *explicit*: The owner of the snapshot granted create volume
/// permissions to a specific Amazon Web Services account.
///
/// * *implicit*: An Amazon Web Services account has implicit create volume
///   permissions
/// for all snapshots it owns.
///
/// The list of snapshots returned can be filtered by specifying snapshot IDs,
/// snapshot
/// owners, or Amazon Web Services accounts with create volume permissions. If
/// no options are specified,
/// Amazon EC2 returns all snapshots for which you have create volume
/// permissions.
///
/// If you specify one or more snapshot IDs, only snapshots that have the
/// specified IDs are
/// returned. If you specify an invalid snapshot ID, an error is returned. If
/// you specify a
/// snapshot ID for which you do not have access, it is not included in the
/// returned
/// results.
///
/// If you specify one or more snapshot owners using the `OwnerIds` option, only
/// snapshots from the specified owners and for which you have access are
/// returned. The results
/// can include the Amazon Web Services account IDs of the specified owners,
/// `amazon` for snapshots
/// owned by Amazon, or `self` for snapshots that you own.
///
/// If you specify a list of restorable users, only snapshots with create
/// snapshot permissions
/// for those users are returned. You can specify Amazon Web Services account
/// IDs (if you own the snapshots),
/// `self` for snapshots for which you own or have explicit permissions, or
/// `all` for public snapshots.
///
/// If you are describing a long list of snapshots, we recommend that you
/// paginate the output to make the
/// list more manageable. For more information, see
/// [Pagination](https://docs.aws.amazon.com/AWSEC2/latest/APIReference/Query-Requests.html#api-pagination).
///
/// For more information about EBS snapshots, see [Amazon EBS
/// snapshots](https://docs.aws.amazon.com/ebs/latest/userguide/ebs-snapshots.html) in the *Amazon EBS User Guide*.
///
/// **Important:**
///
/// We strongly recommend using only paginated requests. Unpaginated requests
/// are
/// susceptible to throttling and timeouts.
pub const DescribeSnapshotsInput = struct {
    /// Checks whether you have the required permissions for the action, without
    /// actually making the request,
    /// and provides an error response. If you have the required permissions, the
    /// error response is `DryRunOperation`.
    /// Otherwise, it is `UnauthorizedOperation`.
    dry_run: ?bool = null,

    /// The filters.
    ///
    /// * `description` - A description of the snapshot.
    ///
    /// * `encrypted` - Indicates whether the snapshot is encrypted
    /// (`true` | `false`)
    ///
    /// * `owner-alias` - The owner alias, from an Amazon-maintained list
    /// (`amazon`).
    /// This is not the user-configured Amazon Web Services account alias set using
    /// the IAM console.
    /// We recommend that you use the related parameter instead of this filter.
    ///
    /// * `owner-id` - The Amazon Web Services account ID of the owner. We recommend
    ///   that
    /// you use the related parameter instead of this filter.
    ///
    /// * `progress` - The progress of the snapshot, as a percentage (for example,
    /// 80%).
    ///
    /// * `snapshot-id` - The snapshot ID.
    ///
    /// * `start-time` - The time stamp when the snapshot was initiated.
    ///
    /// * `status` - The status of the snapshot (`pending` |
    /// `completed` | `error`).
    ///
    /// * `storage-tier` - The storage tier of the snapshot (`archive` |
    /// `standard`).
    ///
    /// * `transfer-type` - The type of operation used to create the snapshot
    ///   (`time-based` | `standard`).
    ///
    /// * `tag`: - The key/value combination of a tag assigned to the resource. Use
    ///   the tag key in the filter name and the tag value as the filter value.
    /// For example, to find all resources that have a tag with the key `Owner` and
    /// the value `TeamA`, specify `tag:Owner` for the filter name and `TeamA` for
    /// the filter value.
    ///
    /// * `tag-key` - The key of a tag assigned to the resource. Use this filter to
    ///   find all resources assigned a tag with a specific key, regardless of the
    ///   tag value.
    ///
    /// * `volume-id` - The ID of the volume the snapshot is for.
    ///
    /// * `volume-size` - The size of the volume, in GiB.
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

    /// Scopes the results to snapshots with the specified owners. You can specify a
    /// combination of
    /// Amazon Web Services account IDs, `self`, and `amazon`.
    owner_ids: ?[]const []const u8 = null,

    /// The IDs of the Amazon Web Services accounts that can create volumes from the
    /// snapshot.
    restorable_by_user_ids: ?[]const []const u8 = null,

    /// The snapshot IDs.
    ///
    /// Default: Describes the snapshots for which you have create volume
    /// permissions.
    snapshot_ids: ?[]const []const u8 = null,
};

pub const DescribeSnapshotsOutput = struct {
    /// The token to include in another request to get the next page of items.
    /// This value is `null` when there are no more items to return.
    next_token: ?[]const u8 = null,

    /// Information about the snapshots.
    snapshots: ?[]const Snapshot = null,

    _arena: std.heap.ArenaAllocator = undefined,

    pub fn deinit(self: *DescribeSnapshotsOutput) void {
        self._arena.deinit();
    }
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, input: DescribeSnapshotsInput, options: Options) !DescribeSnapshotsOutput {
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

fn serializeRequest(alloc: std.mem.Allocator, input: DescribeSnapshotsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpoint("ec2", alloc);

    const host = parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = parsePort(endpoint);

    var body_buf: std.ArrayList(u8) = .{};

    try body_buf.appendSlice(alloc, "Action=DescribeSnapshots&Version=2016-11-15");
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
    if (input.owner_ids) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            var prefix_buf: [256]u8 = undefined;
            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&OwnerIds.Owner.{d}=", .{n}) catch continue;
            try body_buf.appendSlice(alloc, field_prefix);
            try appendUrlEncoded(alloc, &body_buf, item);
        }
    }
    if (input.restorable_by_user_ids) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            var prefix_buf: [256]u8 = undefined;
            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&RestorableByUserIds.member.{d}=", .{n}) catch continue;
            try body_buf.appendSlice(alloc, field_prefix);
            try appendUrlEncoded(alloc, &body_buf, item);
        }
    }
    if (input.snapshot_ids) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            var prefix_buf: [256]u8 = undefined;
            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SnapshotIds.SnapshotId.{d}=", .{n}) catch continue;
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

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !DescribeSnapshotsOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => break,
            else => {},
        }
    }

    var result: DescribeSnapshotsOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "nextToken")) {
                    result.next_token = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "snapshotSet")) {
                    result.snapshots = try serde.deserializeSnapshotList(&reader, alloc, "item");
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
