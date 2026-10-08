const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Filter = @import("filter.zig").Filter;
const DBClusterBacktrack = @import("db_cluster_backtrack.zig").DBClusterBacktrack;
const serde = @import("serde.zig");

pub const DescribeDBClusterBacktracksInput = struct {
    /// If specified, this value is the backtrack identifier of the backtrack to be
    /// described.
    ///
    /// Constraints:
    ///
    /// * Must contain a valid universally unique identifier (UUID). For more
    ///   information about UUIDs, see [Universally unique
    ///   identifier](https://en.wikipedia.org/wiki/Universally_unique_identifier).
    ///
    /// Example: `123e4567-e89b-12d3-a456-426655440000`
    backtrack_identifier: ?[]const u8 = null,

    /// The DB cluster identifier of the DB cluster to be described. This parameter
    /// is stored as a lowercase string.
    ///
    /// Constraints:
    ///
    /// * Must contain from 1 to 63 alphanumeric characters or hyphens.
    /// * First character must be a letter.
    /// * Can't end with a hyphen or contain two consecutive hyphens.
    ///
    /// Example: `my-cluster1`
    db_cluster_identifier: []const u8,

    /// A filter that specifies one or more DB clusters to describe. Supported
    /// filters include the following:
    ///
    /// * `db-cluster-backtrack-id` - Accepts backtrack identifiers. The results
    ///   list includes information about only the backtracks identified by these
    ///   identifiers.
    /// * `db-cluster-backtrack-status` - Accepts any of the following backtrack
    ///   status values:
    ///
    /// * `applying`
    /// * `completed`
    /// * `failed`
    /// * `pending`
    ///
    /// The results list includes information about only the backtracks identified
    /// by these values.
    filters: ?[]const Filter = null,

    /// An optional pagination token provided by a previous
    /// `DescribeDBClusterBacktracks` request. If this parameter is specified, the
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
};

pub const DescribeDBClusterBacktracksOutput = struct {
    /// Contains a list of backtracks for the user.
    db_cluster_backtracks: ?[]const DBClusterBacktrack = null,

    /// A pagination token that can be used in a later `DescribeDBClusterBacktracks`
    /// request.
    marker: ?[]const u8 = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeDBClusterBacktracksInput, options: CallOptions) !DescribeDBClusterBacktracksOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeDBClusterBacktracksInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("rds", "RDS", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=DescribeDBClusterBacktracks&Version=2014-10-31");
    if (input.backtrack_identifier) |v| {
        try body_buf.appendSlice(allocator, "&BacktrackIdentifier=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    try body_buf.appendSlice(allocator, "&DBClusterIdentifier=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.db_cluster_identifier);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeDBClusterBacktracksOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "DescribeDBClusterBacktracksResult")) break;
            },
            else => {},
        }
    }

    var result: DescribeDBClusterBacktracksOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "DBClusterBacktracks")) {
                    result.db_cluster_backtracks = try serde.deserializeDBClusterBacktrackList(allocator, &reader, "DBClusterBacktrack");
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
