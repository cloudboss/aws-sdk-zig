const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Filter = @import("filter.zig").Filter;
const DBClusterSnapshot = @import("db_cluster_snapshot.zig").DBClusterSnapshot;
const serde = @import("serde.zig");

pub const DescribeDBClusterSnapshotsInput = struct {
    /// The ID of the DB cluster to retrieve the list of DB cluster snapshots for.
    /// This parameter can't be used in conjunction with the
    /// `DBClusterSnapshotIdentifier` parameter. This parameter isn't
    /// case-sensitive.
    ///
    /// Constraints:
    ///
    /// * If supplied, must match the identifier of an existing DBCluster.
    db_cluster_identifier: ?[]const u8 = null,

    /// A specific DB cluster resource ID to describe.
    db_cluster_resource_id: ?[]const u8 = null,

    /// A specific DB cluster snapshot identifier to describe. This parameter can't
    /// be used in conjunction with the `DBClusterIdentifier` parameter. This value
    /// is stored as a lowercase string.
    ///
    /// Constraints:
    ///
    /// * If supplied, must match the identifier of an existing DBClusterSnapshot.
    /// * If this identifier is for an automated snapshot, the `SnapshotType`
    ///   parameter must also be specified.
    db_cluster_snapshot_identifier: ?[]const u8 = null,

    /// A filter that specifies one or more DB cluster snapshots to describe.
    ///
    /// Supported filters:
    ///
    /// * `db-cluster-id` - Accepts DB cluster identifiers and DB cluster Amazon
    ///   Resource Names (ARNs).
    /// * `db-cluster-snapshot-id` - Accepts DB cluster snapshot identifiers.
    /// * `snapshot-type` - Accepts types of DB cluster snapshots.
    /// * `engine` - Accepts names of database engines.
    filters: ?[]const Filter = null,

    /// Specifies whether to include manual DB cluster snapshots that are public and
    /// can be copied or restored by any Amazon Web Services account. By default,
    /// the public snapshots are not included.
    ///
    /// You can share a manual DB cluster snapshot as public by using the
    /// ModifyDBClusterSnapshotAttribute API action.
    include_public: ?bool = null,

    /// Specifies whether to include shared manual DB cluster snapshots from other
    /// Amazon Web Services accounts that this Amazon Web Services account has been
    /// given permission to copy or restore. By default, these snapshots are not
    /// included.
    ///
    /// You can give an Amazon Web Services account permission to restore a manual
    /// DB cluster snapshot from another Amazon Web Services account by the
    /// `ModifyDBClusterSnapshotAttribute` API action.
    include_shared: ?bool = null,

    /// An optional pagination token provided by a previous
    /// `DescribeDBClusterSnapshots` request. If this parameter is specified, the
    /// response includes only records beyond the marker, up to the value specified
    /// by `MaxRecords`.
    marker: ?[]const u8 = null,

    /// The maximum number of records to include in the response. If more records
    /// exist than the specified `MaxRecords` value, a pagination token called a
    /// marker is included in the response so you can retrieve the remaining
    /// results.
    ///
    /// Default: 100
    ///
    /// Constraints: Minimum 20, maximum 100.
    max_records: ?i32 = null,

    /// The type of DB cluster snapshots to be returned. You can specify one of the
    /// following values:
    ///
    /// * `automated` - Return all DB cluster snapshots that have been automatically
    ///   taken by Amazon RDS for my Amazon Web Services account.
    /// * `manual` - Return all DB cluster snapshots that have been taken by my
    ///   Amazon Web Services account.
    /// * `shared` - Return all manual DB cluster snapshots that have been shared to
    ///   my Amazon Web Services account.
    /// * `public` - Return all DB cluster snapshots that have been marked as
    ///   public.
    ///
    /// If you don't specify a `SnapshotType` value, then both automated and manual
    /// DB cluster snapshots are returned. You can include shared DB cluster
    /// snapshots with these results by enabling the `IncludeShared` parameter. You
    /// can include public DB cluster snapshots with these results by enabling the
    /// `IncludePublic` parameter.
    ///
    /// The `IncludeShared` and `IncludePublic` parameters don't apply for
    /// `SnapshotType` values of `manual` or `automated`. The `IncludePublic`
    /// parameter doesn't apply when `SnapshotType` is set to `shared`. The
    /// `IncludeShared` parameter doesn't apply when `SnapshotType` is set to
    /// `public`.
    snapshot_type: ?[]const u8 = null,
};

pub const DescribeDBClusterSnapshotsOutput = struct {
    /// Provides a list of DB cluster snapshots for the user.
    db_cluster_snapshots: ?[]const DBClusterSnapshot = null,

    /// An optional pagination token provided by a previous
    /// `DescribeDBClusterSnapshots` request. If this parameter is specified, the
    /// response includes only records beyond the marker, up to the value specified
    /// by `MaxRecords`.
    marker: ?[]const u8 = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeDBClusterSnapshotsInput, options: CallOptions) !DescribeDBClusterSnapshotsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "rds", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeDBClusterSnapshotsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("rds", "RDS", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=DescribeDBClusterSnapshots&Version=2014-10-31");
    if (input.db_cluster_identifier) |v| {
        try body_buf.appendSlice(allocator, "&DBClusterIdentifier=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.db_cluster_resource_id) |v| {
        try body_buf.appendSlice(allocator, "&DbClusterResourceId=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.db_cluster_snapshot_identifier) |v| {
        try body_buf.appendSlice(allocator, "&DBClusterSnapshotIdentifier=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.filters) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Filters.Filter.{d}.Name=", .{n}) catch continue;
                try body_buf.appendSlice(allocator, field_prefix);
                try aws.url.appendUrlEncoded(allocator, &body_buf, item.name);
            }
            for (item.values, 0..) |item_1, idx_1| {
                const n_1 = idx_1 + 1;
                {
                    var prefix_buf: [256]u8 = undefined;
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Filters.Filter.{d}.Values.Value.{d}=", .{n, n_1}) catch continue;
                    try body_buf.appendSlice(allocator, field_prefix);
                    try aws.url.appendUrlEncoded(allocator, &body_buf, item_1);
                }
            }
        }
    }
    if (input.include_public) |v| {
        try body_buf.appendSlice(allocator, "&IncludePublic=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, if (v) "true" else "false");
    }
    if (input.include_shared) |v| {
        try body_buf.appendSlice(allocator, "&IncludeShared=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, if (v) "true" else "false");
    }
    if (input.marker) |v| {
        try body_buf.appendSlice(allocator, "&Marker=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.max_records) |v| {
        try body_buf.appendSlice(allocator, "&MaxRecords=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{v}) catch "");
    }
    if (input.snapshot_type) |v| {
        try body_buf.appendSlice(allocator, "&SnapshotType=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeDBClusterSnapshotsOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "DescribeDBClusterSnapshotsResult")) break;
            },
            else => {},
        }
    }

    var result: DescribeDBClusterSnapshotsOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "DBClusterSnapshots")) {
                    result.db_cluster_snapshots = try serde.deserializeDBClusterSnapshotList(allocator, &reader, "DBClusterSnapshot");
                } else if (std.mem.eql(u8, e.local, "Marker")) {
                    result.marker = try allocator.dupe(u8, try reader.readElementText());
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
