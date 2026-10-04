const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Filter = @import("filter.zig").Filter;
const DBClusterEndpoint = @import("db_cluster_endpoint.zig").DBClusterEndpoint;
const serde = @import("serde.zig");

pub const DescribeDBClusterEndpointsInput = struct {
    /// The identifier of the endpoint to describe. This parameter is stored as a
    /// lowercase string.
    db_cluster_endpoint_identifier: ?[]const u8 = null,

    /// The DB cluster identifier of the DB cluster associated with the endpoint.
    /// This parameter is
    /// stored as a lowercase string.
    db_cluster_identifier: ?[]const u8 = null,

    /// A set of name-value pairs that define which endpoints to include in the
    /// output.
    /// The filters are specified as name-value pairs, in the format
    /// `Name=*endpoint_type*,Values=*endpoint_type1*,*endpoint_type2*,...`.
    /// `Name` can be one of: `db-cluster-endpoint-type`,
    /// `db-cluster-endpoint-custom-type`, `db-cluster-endpoint-id`,
    /// `db-cluster-endpoint-status`.
    /// `Values` for the ` db-cluster-endpoint-type` filter can be one or more of:
    /// `reader`, `writer`, `custom`.
    /// `Values` for the `db-cluster-endpoint-custom-type` filter can be one or more
    /// of: `reader`, `any`.
    /// `Values` for the `db-cluster-endpoint-status` filter can be one or more of:
    /// `available`, `creating`, `deleting`, `inactive`, `modifying`.
    filters: ?[]const Filter = null,

    /// An optional pagination token provided by a previous
    /// `DescribeDBClusterEndpoints` request.
    /// If this parameter is specified, the response includes
    /// only records beyond the marker,
    /// up to the value specified by `MaxRecords`.
    marker: ?[]const u8 = null,

    /// The maximum number of records to include in the response.
    /// If more records exist than the specified `MaxRecords` value,
    /// a pagination token called a marker is included in the response
    /// so you can retrieve the remaining results.
    ///
    /// Default: 100
    ///
    /// Constraints: Minimum 20, maximum 100.
    max_records: ?i32 = null,
};

pub const DescribeDBClusterEndpointsOutput = struct {
    /// Contains the details of the endpoints associated with the cluster
    /// and matching any filter conditions.
    db_cluster_endpoints: ?[]const DBClusterEndpoint = null,

    /// An optional pagination token provided by a previous
    /// `DescribeDBClusterEndpoints` request.
    /// If this parameter is specified, the response includes
    /// only records beyond the marker,
    /// up to the value specified by `MaxRecords`.
    marker: ?[]const u8 = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeDBClusterEndpointsInput, options: CallOptions) !DescribeDBClusterEndpointsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeDBClusterEndpointsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("rds", "Neptune", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=DescribeDBClusterEndpoints&Version=2014-10-31");
    if (input.db_cluster_endpoint_identifier) |v| {
        try body_buf.appendSlice(allocator, "&DBClusterEndpointIdentifier=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeDBClusterEndpointsOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "DescribeDBClusterEndpointsResult")) break;
            },
            else => {},
        }
    }

    var result: DescribeDBClusterEndpointsOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "DBClusterEndpoints")) {
                    result.db_cluster_endpoints = try serde.deserializeDBClusterEndpointList(allocator, &reader, "DBClusterEndpointList");
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
