const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const SnapshotSortingEntity = @import("snapshot_sorting_entity.zig").SnapshotSortingEntity;
const Snapshot = @import("snapshot.zig").Snapshot;
const serde = @import("serde.zig");

pub const DescribeClusterSnapshotsInput = struct {
    /// A value that indicates whether to return snapshots only for an existing
    /// cluster.
    /// You can perform table-level restore only by using a snapshot of an existing
    /// cluster,
    /// that is, a cluster that has not been deleted. Values for this parameter work
    /// as follows:
    ///
    /// * If `ClusterExists` is set to `true`,
    /// `ClusterIdentifier` is required.
    ///
    /// * If `ClusterExists` is set to `false` and
    /// `ClusterIdentifier` isn't specified, all snapshots
    /// associated with deleted clusters (orphaned snapshots) are returned.
    ///
    /// * If `ClusterExists` is set to `false` and
    /// `ClusterIdentifier` is specified for a deleted cluster, snapshots
    /// associated with that cluster are returned.
    ///
    /// * If `ClusterExists` is set to `false` and
    /// `ClusterIdentifier` is specified for an existing cluster, no
    /// snapshots are returned.
    cluster_exists: ?bool = null,

    /// The identifier of the cluster which generated the requested snapshots.
    cluster_identifier: ?[]const u8 = null,

    /// A time value that requests only snapshots created at or before the specified
    /// time.
    /// The time value is specified in ISO 8601 format. For more information about
    /// ISO 8601, go
    /// to the [ISO8601 Wikipedia
    /// page.](http://en.wikipedia.org/wiki/ISO_8601)
    ///
    /// Example: `2012-07-16T18:00:00Z`
    end_time: ?i64 = null,

    /// An optional parameter that specifies the starting point to return a set of
    /// response
    /// records. When the results of a DescribeClusterSnapshots request exceed
    /// the value specified in `MaxRecords`, Amazon Web Services returns a value in
    /// the
    /// `Marker` field of the response. You can retrieve the next set of response
    /// records by providing the returned marker value in the `Marker` parameter and
    /// retrying the request.
    marker: ?[]const u8 = null,

    /// The maximum number of response records to return in each call. If the number
    /// of
    /// remaining response records exceeds the specified `MaxRecords` value, a value
    /// is returned in a `marker` field of the response. You can retrieve the next
    /// set of records by retrying the command with the returned marker value.
    ///
    /// Default: `100`
    ///
    /// Constraints: minimum 20, maximum 100.
    max_records: ?i32 = null,

    /// The Amazon Web Services account used to create or copy the snapshot. Use
    /// this field to
    /// filter the results to snapshots owned by a particular account. To describe
    /// snapshots you
    /// own, either specify your Amazon Web Services account, or do not specify the
    /// parameter.
    owner_account: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the snapshot associated with the message
    /// to describe cluster snapshots.
    snapshot_arn: ?[]const u8 = null,

    /// The snapshot identifier of the snapshot about which to return
    /// information.
    snapshot_identifier: ?[]const u8 = null,

    /// The type of snapshots for which you are requesting information. By default,
    /// snapshots of all types are returned.
    ///
    /// Valid Values: `automated` | `manual`
    snapshot_type: ?[]const u8 = null,

    sorting_entities: ?[]const SnapshotSortingEntity = null,

    /// A value that requests only snapshots created at or after the specified time.
    /// The
    /// time value is specified in ISO 8601 format. For more information about ISO
    /// 8601, go to
    /// the [ISO8601 Wikipedia page.](http://en.wikipedia.org/wiki/ISO_8601)
    ///
    /// Example: `2012-07-16T18:00:00Z`
    start_time: ?i64 = null,

    /// A tag key or keys for which you want to return all matching cluster
    /// snapshots that
    /// are associated with the specified key or keys. For example, suppose that you
    /// have
    /// snapshots that are tagged with keys called `owner` and
    /// `environment`. If you specify both of these tag keys in the request,
    /// Amazon Redshift returns a response with the snapshots that have either or
    /// both of these tag
    /// keys associated with them.
    tag_keys: ?[]const []const u8 = null,

    /// A tag value or values for which you want to return all matching cluster
    /// snapshots
    /// that are associated with the specified tag value or values. For example,
    /// suppose that
    /// you have snapshots that are tagged with values called `admin` and
    /// `test`. If you specify both of these tag values in the request, Amazon
    /// Redshift
    /// returns a response with the snapshots that have either or both of these tag
    /// values
    /// associated with them.
    tag_values: ?[]const []const u8 = null,
};

pub const DescribeClusterSnapshotsOutput = struct {
    /// A value that indicates the starting point for the next set of response
    /// records in a
    /// subsequent request. If a value is returned in a response, you can retrieve
    /// the next set
    /// of records by providing this returned marker value in the `Marker` parameter
    /// and retrying the command. If the `Marker` field is empty, all response
    /// records have been retrieved for the request.
    marker: ?[]const u8 = null,

    /// A list of Snapshot instances.
    snapshots: ?[]const Snapshot = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeClusterSnapshotsInput, options: CallOptions) !DescribeClusterSnapshotsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "redshift", client.config.http_client.clock_skew_offset);

    var response = try client.config.http_client.sendRequestWithOptions(&request, client.options);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = try parseErrorResponse(client.allocator, response.body, response.status);
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeClusterSnapshotsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("redshift", "Redshift", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=DescribeClusterSnapshots&Version=2012-12-01");
    if (input.cluster_exists) |v| {
        try body_buf.appendSlice(allocator, "&ClusterExists=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, if (v) "true" else "false");
    }
    if (input.cluster_identifier) |v| {
        try body_buf.appendSlice(allocator, "&ClusterIdentifier=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.end_time) |v| {
        try body_buf.appendSlice(allocator, "&EndTime=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{v}) catch "");
    }
    if (input.marker) |v| {
        try body_buf.appendSlice(allocator, "&Marker=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.max_records) |v| {
        try body_buf.appendSlice(allocator, "&MaxRecords=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{v}) catch "");
    }
    if (input.owner_account) |v| {
        try body_buf.appendSlice(allocator, "&OwnerAccount=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.snapshot_arn) |v| {
        try body_buf.appendSlice(allocator, "&SnapshotArn=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.snapshot_identifier) |v| {
        try body_buf.appendSlice(allocator, "&SnapshotIdentifier=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.snapshot_type) |v| {
        try body_buf.appendSlice(allocator, "&SnapshotType=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.sorting_entities) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SortingEntities.SnapshotSortingEntity.{d}.Attribute=", .{n}) catch continue;
                try body_buf.appendSlice(allocator, field_prefix);
                try aws.url.appendUrlEncoded(allocator, &body_buf, item.attribute.wireName());
            }
            {
                var prefix_buf: [256]u8 = undefined;
                if (item.sort_order) |fv_1| {
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SortingEntities.SnapshotSortingEntity.{d}.SortOrder=", .{n}) catch continue;
                    try body_buf.appendSlice(allocator, field_prefix);
                    try aws.url.appendUrlEncoded(allocator, &body_buf, fv_1.wireName());
                }
            }
        }
    }
    if (input.start_time) |v| {
        try body_buf.appendSlice(allocator, "&StartTime=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{v}) catch "");
    }
    if (input.tag_keys) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            var prefix_buf: [256]u8 = undefined;
            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&TagKeys.TagKey.{d}=", .{n}) catch continue;
            try body_buf.appendSlice(allocator, field_prefix);
            try aws.url.appendUrlEncoded(allocator, &body_buf, item);
        }
    }
    if (input.tag_values) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            var prefix_buf: [256]u8 = undefined;
            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&TagValues.TagValue.{d}=", .{n}) catch continue;
            try body_buf.appendSlice(allocator, field_prefix);
            try aws.url.appendUrlEncoded(allocator, &body_buf, item);
        }
    }

    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-www-form-urlencoded");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeClusterSnapshotsOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "DescribeClusterSnapshotsResult")) break;
            },
            else => {},
        }
    }

    var result: DescribeClusterSnapshotsOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Marker")) {
                    result.marker = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Snapshots")) {
                    result.snapshots = try serde.deserializeSnapshotList(allocator, &reader, "Snapshot");
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
