const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Filter = @import("filter.zig").Filter;
const DBCluster = @import("db_cluster.zig").DBCluster;
const serde = @import("serde.zig");

pub const DescribeDBClustersInput = struct {
    /// The user-supplied DB cluster identifier or the Amazon Resource Name (ARN) of
    /// the DB cluster. If this parameter is specified, information for only the
    /// specific DB cluster is returned. This parameter isn't case-sensitive.
    ///
    /// Constraints:
    ///
    /// * If supplied, must match an existing DB cluster identifier.
    db_cluster_identifier: ?[]const u8 = null,

    /// A filter that specifies one or more DB clusters to describe.
    ///
    /// Supported Filters:
    ///
    /// * `clone-group-id` - Accepts clone group identifiers. The results list only
    ///   includes information about the DB clusters associated with these clone
    ///   groups.
    /// * `db-cluster-id` - Accepts DB cluster identifiers and DB cluster Amazon
    ///   Resource Names (ARNs). The results list only includes information about
    ///   the DB clusters identified by these ARNs.
    /// * `db-cluster-resource-id` - Accepts DB cluster resource identifiers. The
    ///   results list will only include information about the DB clusters
    ///   identified by these DB cluster resource identifiers.
    /// * `domain` - Accepts Active Directory directory IDs. The results list only
    ///   includes information about the DB clusters associated with these domains.
    /// * `engine` - Accepts engine names. The results list only includes
    ///   information about the DB clusters for these engines.
    filters: ?[]const Filter = null,

    /// Specifies whether the output includes information about clusters shared from
    /// other Amazon Web Services accounts.
    include_shared: ?bool = null,

    /// An optional pagination token provided by a previous `DescribeDBClusters`
    /// request. If this parameter is specified, the response includes only records
    /// beyond the marker, up to the value specified by `MaxRecords`.
    marker: ?[]const u8 = null,

    /// The maximum number of records to include in the response. If more records
    /// exist than the specified `MaxRecords` value, a pagination token called a
    /// marker is included in the response so you can retrieve the remaining
    /// results.
    ///
    /// Default: 100
    ///
    /// Constraints: Minimum 20, maximum 100
    max_records: ?i32 = null,
};

pub const DescribeDBClustersOutput = struct {
    /// Contains a list of DB clusters for the user.
    db_clusters: ?[]const DBCluster = null,

    /// A pagination token that can be used in a later `DescribeDBClusters` request.
    marker: ?[]const u8 = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeDBClustersInput, options: CallOptions) !DescribeDBClustersOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeDBClustersInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("rds", "RDS", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=DescribeDBClusters&Version=2014-10-31");
    if (input.db_cluster_identifier) |v| {
        try body_buf.appendSlice(allocator, "&DBClusterIdentifier=");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeDBClustersOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "DescribeDBClustersResult")) break;
            },
            else => {},
        }
    }

    var result: DescribeDBClustersOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "DBClusters")) {
                    result.db_clusters = try serde.deserializeDBClusterList(allocator, &reader, "DBCluster");
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
