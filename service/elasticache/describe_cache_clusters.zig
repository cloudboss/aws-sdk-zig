const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const CacheCluster = @import("cache_cluster.zig").CacheCluster;
const serde = @import("serde.zig");

pub const DescribeCacheClustersInput = struct {
    /// The user-supplied cluster identifier. If this parameter is specified, only
    /// information
    /// about that specific cluster is returned. This parameter isn't case
    /// sensitive.
    cache_cluster_id: ?[]const u8 = null,

    /// An optional marker returned from a prior request. Use this marker for
    /// pagination of
    /// results from this operation. If this parameter is specified, the response
    /// includes only
    /// records beyond the marker, up to the value specified by `MaxRecords`.
    marker: ?[]const u8 = null,

    /// The maximum number of records to include in the response. If more records
    /// exist than
    /// the specified `MaxRecords` value, a marker is included in the response so
    /// that the remaining results can be retrieved.
    ///
    /// Default: 100
    ///
    /// Constraints: minimum 20; maximum 100.
    max_records: ?i32 = null,

    /// An optional flag that can be included in the `DescribeCacheCluster` request
    /// to show only nodes (API/CLI: clusters) that are not members of a replication
    /// group. In
    /// practice, this means Memcached and single node Valkey or Redis OSS clusters.
    show_cache_clusters_not_in_replication_groups: ?bool = null,

    /// An optional flag that can be included in the `DescribeCacheCluster` request
    /// to retrieve information about the individual cache nodes.
    show_cache_node_info: ?bool = null,
};

pub const DescribeCacheClustersOutput = struct {
    /// A list of clusters. Each item in the list contains detailed information
    /// about one
    /// cluster.
    cache_clusters: ?[]const CacheCluster = null,

    /// Provides an identifier to allow retrieval of paginated results.
    marker: ?[]const u8 = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeCacheClustersInput, options: CallOptions) !DescribeCacheClustersOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "elasticache", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeCacheClustersInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("elasticache", "ElastiCache", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=DescribeCacheClusters&Version=2015-02-02");
    if (input.cache_cluster_id) |v| {
        try body_buf.appendSlice(allocator, "&CacheClusterId=");
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
    if (input.show_cache_clusters_not_in_replication_groups) |v| {
        try body_buf.appendSlice(allocator, "&ShowCacheClustersNotInReplicationGroups=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, if (v) "true" else "false");
    }
    if (input.show_cache_node_info) |v| {
        try body_buf.appendSlice(allocator, "&ShowCacheNodeInfo=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, if (v) "true" else "false");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeCacheClustersOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "DescribeCacheClustersResult")) break;
            },
            else => {},
        }
    }

    var result: DescribeCacheClustersOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "CacheClusters")) {
                    result.cache_clusters = try serde.deserializeCacheClusterList(allocator, &reader, "CacheCluster");
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
