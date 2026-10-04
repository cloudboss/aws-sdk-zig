const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Filter = @import("filter.zig").Filter;
const DBClusterAutomatedBackup = @import("db_cluster_automated_backup.zig").DBClusterAutomatedBackup;
const serde = @import("serde.zig");

pub const DescribeDBClusterAutomatedBackupsInput = struct {
    /// (Optional) The user-supplied DB cluster identifier. If this parameter is
    /// specified, it must match the identifier of an existing DB cluster. It
    /// returns information from the specific DB cluster's automated backup. This
    /// parameter isn't case-sensitive.
    db_cluster_identifier: ?[]const u8 = null,

    /// The resource ID of the DB cluster that is the source of the automated
    /// backup. This parameter isn't case-sensitive.
    db_cluster_resource_id: ?[]const u8 = null,

    /// A filter that specifies which resources to return based on status.
    ///
    /// Supported filters are the following:
    ///
    /// * `status`
    ///
    /// * `retained` - Automated backups for deleted clusters and after backup
    ///   replication is stopped.
    ///
    /// * `db-cluster-id` - Accepts DB cluster identifiers and Amazon Resource Names
    ///   (ARNs). The results list includes only information about the DB cluster
    ///   automated backups identified by these ARNs.
    /// * `db-cluster-resource-id` - Accepts DB resource identifiers and Amazon
    ///   Resource Names (ARNs). The results list includes only information about
    ///   the DB cluster resources identified by these ARNs.
    ///
    /// Returns all resources by default. The status for each resource is specified
    /// in the response.
    filters: ?[]const Filter = null,

    /// The pagination token provided in the previous request. If this parameter is
    /// specified the response includes only records beyond the marker, up to
    /// `MaxRecords`.
    marker: ?[]const u8 = null,

    /// The maximum number of records to include in the response. If more records
    /// exist than the specified `MaxRecords` value, a pagination token called a
    /// marker is included in the response so that you can retrieve the remaining
    /// results.
    max_records: ?i32 = null,
};

pub const DescribeDBClusterAutomatedBackupsOutput = struct {
    /// A list of `DBClusterAutomatedBackup` backups.
    db_cluster_automated_backups: ?[]const DBClusterAutomatedBackup = null,

    /// The pagination token provided in the previous request. If this parameter is
    /// specified the response includes only records beyond the marker, up to
    /// `MaxRecords`.
    marker: ?[]const u8 = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeDBClusterAutomatedBackupsInput, options: CallOptions) !DescribeDBClusterAutomatedBackupsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeDBClusterAutomatedBackupsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("rds", "RDS", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=DescribeDBClusterAutomatedBackups&Version=2014-10-31");
    if (input.db_cluster_identifier) |v| {
        try body_buf.appendSlice(allocator, "&DBClusterIdentifier=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.db_cluster_resource_id) |v| {
        try body_buf.appendSlice(allocator, "&DbClusterResourceId=");
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
    if (input.marker) |v| {
        try body_buf.appendSlice(allocator, "&Marker=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.max_records) |v| {
        try body_buf.appendSlice(allocator, "&MaxRecords=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{v}) catch "");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeDBClusterAutomatedBackupsOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "DescribeDBClusterAutomatedBackupsResult")) break;
            },
            else => {},
        }
    }

    var result: DescribeDBClusterAutomatedBackupsOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "DBClusterAutomatedBackups")) {
                    result.db_cluster_automated_backups = try serde.deserializeDBClusterAutomatedBackupList(allocator, &reader, "DBClusterAutomatedBackup");
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
