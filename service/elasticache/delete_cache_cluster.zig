const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const CacheCluster = @import("cache_cluster.zig").CacheCluster;
const serde = @import("serde.zig");

pub const DeleteCacheClusterInput = struct {
    /// The cluster identifier for the cluster to be deleted. This parameter is not
    /// case
    /// sensitive.
    cache_cluster_id: []const u8,

    /// The user-supplied name of a final cluster snapshot. This is the unique name
    /// that
    /// identifies the snapshot. ElastiCache creates the snapshot, and then deletes
    /// the cluster
    /// immediately afterward.
    final_snapshot_identifier: ?[]const u8 = null,
};

pub const DeleteCacheClusterOutput = struct {
    cache_cluster: ?CacheCluster = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DeleteCacheClusterInput, options: CallOptions) !DeleteCacheClusterOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DeleteCacheClusterInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("elasticache", "ElastiCache", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=DeleteCacheCluster&Version=2015-02-02");
    try body_buf.appendSlice(allocator, "&CacheClusterId=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.cache_cluster_id);
    if (input.final_snapshot_identifier) |v| {
        try body_buf.appendSlice(allocator, "&FinalSnapshotIdentifier=");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DeleteCacheClusterOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "DeleteCacheClusterResult")) break;
            },
            else => {},
        }
    }

    var result: DeleteCacheClusterOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "CacheCluster")) {
                    result.cache_cluster = try serde.deserializeCacheCluster(allocator, &reader);
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
