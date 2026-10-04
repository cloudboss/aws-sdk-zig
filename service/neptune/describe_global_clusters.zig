const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const GlobalCluster = @import("global_cluster.zig").GlobalCluster;
const serde = @import("serde.zig");

pub const DescribeGlobalClustersInput = struct {
    /// The user-supplied DB cluster identifier. If this parameter is specified,
    /// only information about the specified DB cluster is returned. This parameter
    /// is not case-sensitive.
    ///
    /// Constraints: If supplied, must match an existing DB cluster identifier.
    global_cluster_identifier: ?[]const u8 = null,

    /// (*Optional*) A pagination token returned by a previous
    /// call to `DescribeGlobalClusters`. If this parameter is specified,
    /// the response will only include records beyond the marker, up to the number
    /// specified by `MaxRecords`.
    marker: ?[]const u8 = null,

    /// The maximum number of records to include in the response. If more records
    /// exist than the specified `MaxRecords` value, a pagination marker token
    /// is included in the response that you can use to retrieve the remaining
    /// results.
    ///
    /// Default: `100`
    ///
    /// Constraints: Minimum 20, maximum 100.
    max_records: ?i32 = null,
};

pub const DescribeGlobalClustersOutput = struct {
    /// The list of global clusters and instances returned by this request.
    global_clusters: ?[]const GlobalCluster = null,

    /// A pagination token. If this parameter is returned in the response,
    /// more records are available, which can be retrieved by one or more additional
    /// calls to `DescribeGlobalClusters`.
    marker: ?[]const u8 = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeGlobalClustersInput, options: CallOptions) !DescribeGlobalClustersOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeGlobalClustersInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("rds", "Neptune", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=DescribeGlobalClusters&Version=2014-10-31");
    if (input.global_cluster_identifier) |v| {
        try body_buf.appendSlice(allocator, "&GlobalClusterIdentifier=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeGlobalClustersOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "DescribeGlobalClustersResult")) break;
            },
            else => {},
        }
    }

    var result: DescribeGlobalClustersOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "GlobalClusters")) {
                    result.global_clusters = try serde.deserializeGlobalClusterList(allocator, &reader, "GlobalClusterMember");
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
