const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ServerlessCacheSnapshot = @import("serverless_cache_snapshot.zig").ServerlessCacheSnapshot;
const serde = @import("serde.zig");

pub const DescribeServerlessCacheSnapshotsInput = struct {
    /// The maximum number of records to include in the response. If more records
    /// exist than
    /// the specified max-results value, a market is included in the response so
    /// that remaining results
    /// can be retrieved. Available for Valkey, Redis OSS and Serverless Memcached
    /// only.The default is 50. The Validation Constraints are a maximum of 50.
    max_results: ?i32 = null,

    /// An optional marker returned from a prior request to support pagination of
    /// results from this operation.
    /// If this parameter is specified, the response includes only records beyond
    /// the marker,
    /// up to the value specified by max-results. Available for Valkey, Redis OSS
    /// and Serverless Memcached only.
    next_token: ?[]const u8 = null,

    /// The identifier of serverless cache. If this parameter is specified,
    /// only snapshots associated with that specific serverless cache are described.
    /// Available for Valkey, Redis OSS and Serverless Memcached only.
    serverless_cache_name: ?[]const u8 = null,

    /// The identifier of the serverless cache’s snapshot.
    /// If this parameter is specified, only this snapshot is described. Available
    /// for Valkey, Redis OSS and Serverless Memcached only.
    serverless_cache_snapshot_name: ?[]const u8 = null,

    /// The type of snapshot that is being described. Available for Valkey, Redis
    /// OSS and Serverless Memcached only.
    snapshot_type: ?[]const u8 = null,
};

pub const DescribeServerlessCacheSnapshotsOutput = struct {
    /// An optional marker returned from a prior request to support pagination of
    /// results from this operation.
    /// If this parameter is specified, the response includes only records beyond
    /// the marker,
    /// up to the value specified by max-results. Available for Valkey, Redis OSS
    /// and Serverless Memcached only.
    next_token: ?[]const u8 = null,

    /// The serverless caches snapshots associated with a given description request.
    /// Available for Valkey, Redis OSS and Serverless Memcached only.
    serverless_cache_snapshots: ?[]const ServerlessCacheSnapshot = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeServerlessCacheSnapshotsInput, options: CallOptions) !DescribeServerlessCacheSnapshotsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeServerlessCacheSnapshotsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("elasticache", "ElastiCache", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=DescribeServerlessCacheSnapshots&Version=2015-02-02");
    if (input.max_results) |v| {
        try body_buf.appendSlice(allocator, "&MaxResults=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{v}) catch "");
    }
    if (input.next_token) |v| {
        try body_buf.appendSlice(allocator, "&NextToken=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.serverless_cache_name) |v| {
        try body_buf.appendSlice(allocator, "&ServerlessCacheName=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.serverless_cache_snapshot_name) |v| {
        try body_buf.appendSlice(allocator, "&ServerlessCacheSnapshotName=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeServerlessCacheSnapshotsOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "DescribeServerlessCacheSnapshotsResult")) break;
            },
            else => {},
        }
    }

    var result: DescribeServerlessCacheSnapshotsOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "NextToken")) {
                    result.next_token = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ServerlessCacheSnapshots")) {
                    result.serverless_cache_snapshots = try serde.deserializeServerlessCacheSnapshotList(allocator, &reader, "ServerlessCacheSnapshot");
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
