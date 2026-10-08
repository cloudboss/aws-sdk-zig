const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Filter = @import("filter.zig").Filter;
const DBSnapshotTenantDatabase = @import("db_snapshot_tenant_database.zig").DBSnapshotTenantDatabase;
const serde = @import("serde.zig");

pub const DescribeDBSnapshotTenantDatabasesInput = struct {
    /// The ID of the DB instance used to create the DB snapshots. This parameter
    /// isn't case-sensitive.
    ///
    /// Constraints:
    ///
    /// * If supplied, must match the identifier of an existing `DBInstance`.
    db_instance_identifier: ?[]const u8 = null,

    /// A specific DB resource identifier to describe.
    dbi_resource_id: ?[]const u8 = null,

    /// The ID of a DB snapshot that contains the tenant databases to describe. This
    /// value is stored as a lowercase string.
    ///
    /// Constraints:
    ///
    /// * If you specify this parameter, the value must match the ID of an existing
    ///   DB snapshot.
    /// * If you specify an automatic snapshot, you must also specify
    ///   `SnapshotType`.
    db_snapshot_identifier: ?[]const u8 = null,

    /// A filter that specifies one or more tenant databases to describe.
    ///
    /// Supported filters:
    ///
    /// * `tenant-db-name` - Tenant database names. The results list only includes
    ///   information about the tenant databases that match these tenant DB names.
    /// * `tenant-database-resource-id` - Tenant database resource identifiers. The
    ///   results list only includes information about the tenant databases
    ///   contained within the DB snapshots.
    /// * `dbi-resource-id` - DB instance resource identifiers. The results list
    ///   only includes information about snapshots containing tenant databases
    ///   contained within the DB instances identified by these resource
    ///   identifiers.
    /// * `db-instance-id` - Accepts DB instance identifiers and DB instance Amazon
    ///   Resource Names (ARNs).
    /// * `db-snapshot-id` - Accepts DB snapshot identifiers.
    /// * `snapshot-type` - Accepts types of DB snapshots.
    filters: ?[]const Filter = null,

    /// An optional pagination token provided by a previous
    /// `DescribeDBSnapshotTenantDatabases` request. If this parameter is specified,
    /// the response includes only records beyond the marker, up to the value
    /// specified by `MaxRecords`.
    marker: ?[]const u8 = null,

    /// The maximum number of records to include in the response. If more records
    /// exist than the specified `MaxRecords` value, a pagination token called a
    /// marker is included in the response so that you can retrieve the remaining
    /// results.
    max_records: ?i32 = null,

    /// The type of DB snapshots to be returned. You can specify one of the
    /// following values:
    ///
    /// * `automated` – All DB snapshots that have been automatically taken by
    ///   Amazon RDS for my Amazon Web Services account.
    /// * `manual` – All DB snapshots that have been taken by my Amazon Web Services
    ///   account.
    /// * `shared` – All manual DB snapshots that have been shared to my Amazon Web
    ///   Services account.
    /// * `public` – All DB snapshots that have been marked as public.
    /// * `awsbackup` – All DB snapshots managed by the Amazon Web Services Backup
    ///   service.
    snapshot_type: ?[]const u8 = null,
};

pub const DescribeDBSnapshotTenantDatabasesOutput = struct {
    /// A list of DB snapshot tenant databases.
    db_snapshot_tenant_databases: ?[]const DBSnapshotTenantDatabase = null,

    /// An optional pagination token provided by a previous request. If this
    /// parameter is specified, the response includes only records beyond the
    /// marker, up to the value specified by `MaxRecords`.
    marker: ?[]const u8 = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeDBSnapshotTenantDatabasesInput, options: CallOptions) !DescribeDBSnapshotTenantDatabasesOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeDBSnapshotTenantDatabasesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("rds", "RDS", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=DescribeDBSnapshotTenantDatabases&Version=2014-10-31");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeDBSnapshotTenantDatabasesOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "DescribeDBSnapshotTenantDatabasesResult")) break;
            },
            else => {},
        }
    }

    var result: DescribeDBSnapshotTenantDatabasesOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "DBSnapshotTenantDatabases")) {
                    result.db_snapshot_tenant_databases = try serde.deserializeDBSnapshotTenantDatabasesList(allocator, &reader, "DBSnapshotTenantDatabase");
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
