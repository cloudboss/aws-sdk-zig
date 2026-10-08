const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Filter = @import("filter.zig").Filter;
const DBSnapshot = @import("db_snapshot.zig").DBSnapshot;
const serde = @import("serde.zig");

pub const DescribeDBSnapshotsInput = struct {
    /// The ID of the DB instance to retrieve the list of DB snapshots for. This
    /// parameter isn't case-sensitive.
    ///
    /// Constraints:
    ///
    /// * If supplied, must match the identifier of an existing DBInstance.
    db_instance_identifier: ?[]const u8 = null,

    /// A specific DB resource ID to describe.
    dbi_resource_id: ?[]const u8 = null,

    /// A specific DB snapshot identifier to describe. This value is stored as a
    /// lowercase string.
    ///
    /// Constraints:
    ///
    /// * If supplied, must match the identifier of an existing DBSnapshot.
    /// * If this identifier is for an automated snapshot, the `SnapshotType`
    ///   parameter must also be specified.
    db_snapshot_identifier: ?[]const u8 = null,

    /// A filter that specifies one or more DB snapshots to describe.
    ///
    /// Supported filters:
    ///
    /// * `db-instance-id` - Accepts DB instance identifiers and DB instance Amazon
    ///   Resource Names (ARNs).
    /// * `db-snapshot-id` - Accepts DB snapshot identifiers.
    /// * `dbi-resource-id` - Accepts identifiers of source DB instances.
    /// * `snapshot-type` - Accepts types of DB snapshots.
    /// * `engine` - Accepts names of database engines.
    filters: ?[]const Filter = null,

    /// Specifies whether to include manual DB cluster snapshots that are public and
    /// can be copied or restored by any Amazon Web Services account. By default,
    /// the public snapshots are not included.
    ///
    /// You can share a manual DB snapshot as public by using the
    /// ModifyDBSnapshotAttribute API.
    ///
    /// This setting doesn't apply to RDS Custom.
    include_public: ?bool = null,

    /// Specifies whether to include shared manual DB cluster snapshots from other
    /// Amazon Web Services accounts that this Amazon Web Services account has been
    /// given permission to copy or restore. By default, these snapshots are not
    /// included.
    ///
    /// You can give an Amazon Web Services account permission to restore a manual
    /// DB snapshot from another Amazon Web Services account by using the
    /// `ModifyDBSnapshotAttribute` API action.
    ///
    /// This setting doesn't apply to RDS Custom.
    include_shared: ?bool = null,

    /// An optional pagination token provided by a previous `DescribeDBSnapshots`
    /// request. If this parameter is specified, the response includes only records
    /// beyond the marker, up to the value specified by `MaxRecords`.
    marker: ?[]const u8 = null,

    /// The maximum number of records to include in the response. If more records
    /// exist than the specified `MaxRecords` value, a pagination token called a
    /// marker is included in the response so that you can retrieve the remaining
    /// results.
    ///
    /// Default: 100
    ///
    /// Constraints: Minimum 20, maximum 100.
    max_records: ?i32 = null,

    /// The type of snapshots to be returned. You can specify one of the following
    /// values:
    ///
    /// * `automated` - Return all DB snapshots that have been automatically taken
    ///   by Amazon RDS for my Amazon Web Services account.
    /// * `manual` - Return all DB snapshots that have been taken by my Amazon Web
    ///   Services account.
    /// * `shared` - Return all manual DB snapshots that have been shared to my
    ///   Amazon Web Services account.
    /// * `public` - Return all DB snapshots that have been marked as public.
    /// * `awsbackup` - Return the DB snapshots managed by the Amazon Web Services
    ///   Backup service.
    ///
    /// For information about Amazon Web Services Backup, see the [ *Amazon Web
    /// Services Backup Developer Guide.*
    /// ](https://docs.aws.amazon.com/aws-backup/latest/devguide/whatisbackup.html)
    ///
    /// The `awsbackup` type does not apply to Aurora.
    ///
    /// If you don't specify a `SnapshotType` value, then both automated and manual
    /// snapshots are returned. Shared and public DB snapshots are not included in
    /// the returned results by default. You can include shared snapshots with these
    /// results by enabling the `IncludeShared` parameter. You can include public
    /// snapshots with these results by enabling the `IncludePublic` parameter.
    ///
    /// The `IncludeShared` and `IncludePublic` parameters don't apply for
    /// `SnapshotType` values of `manual` or `automated`. The `IncludePublic`
    /// parameter doesn't apply when `SnapshotType` is set to `shared`. The
    /// `IncludeShared` parameter doesn't apply when `SnapshotType` is set to
    /// `public`.
    snapshot_type: ?[]const u8 = null,
};

pub const DescribeDBSnapshotsOutput = struct {
    /// A list of `DBSnapshot` instances.
    db_snapshots: ?[]const DBSnapshot = null,

    /// An optional pagination token provided by a previous request. If this
    /// parameter is specified, the response includes only records beyond the
    /// marker, up to the value specified by `MaxRecords`.
    marker: ?[]const u8 = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeDBSnapshotsInput, options: CallOptions) !DescribeDBSnapshotsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeDBSnapshotsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("rds", "RDS", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=DescribeDBSnapshots&Version=2014-10-31");
    if (input.db_instance_identifier) |v| {
        try body_buf.appendSlice(allocator, "&DBInstanceIdentifier=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.dbi_resource_id) |v| {
        try body_buf.appendSlice(allocator, "&DbiResourceId=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.db_snapshot_identifier) |v| {
        try body_buf.appendSlice(allocator, "&DBSnapshotIdentifier=");
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
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Filters.Filter.{d}.Values.Value.{d}=", .{ n, n_1 }) catch continue;
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeDBSnapshotsOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "DescribeDBSnapshotsResult")) break;
            },
            else => {},
        }
    }

    var result: DescribeDBSnapshotsOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "DBSnapshots")) {
                    result.db_snapshots = try serde.deserializeDBSnapshotList(allocator, &reader, "DBSnapshot");
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
