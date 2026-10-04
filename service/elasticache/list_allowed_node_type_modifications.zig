const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const serde = @import("serde.zig");

pub const ListAllowedNodeTypeModificationsInput = struct {
    /// The name of the cluster you want to scale up to a larger node instanced
    /// type.
    /// ElastiCache uses the cluster id to identify the current node type of this
    /// cluster and
    /// from that to create a list of node types you can scale up to.
    ///
    /// You must provide a value for either the `CacheClusterId` or the
    /// `ReplicationGroupId`.
    cache_cluster_id: ?[]const u8 = null,

    /// The name of the replication group want to scale up to a larger node type.
    /// ElastiCache
    /// uses the replication group id to identify the current node type being used
    /// by this
    /// replication group, and from that to create a list of node types you can
    /// scale up
    /// to.
    ///
    /// You must provide a value for either the `CacheClusterId` or the
    /// `ReplicationGroupId`.
    replication_group_id: ?[]const u8 = null,
};

pub const ListAllowedNodeTypeModificationsOutput = struct {
    /// A string list, each element of which specifies a cache node type which you
    /// can use to
    /// scale your cluster or replication group. When scaling down a Valkey or Redis
    /// OSS cluster or
    /// replication group using ModifyCacheCluster or ModifyReplicationGroup, use a
    /// value from
    /// this list for the CacheNodeType parameter.
    scale_down_modifications: ?[]const []const u8 = null,

    /// A string list, each element of which specifies a cache node type which you
    /// can use to
    /// scale your cluster or replication group.
    ///
    /// When scaling up a Valkey or Redis OSS cluster or replication group using
    /// `ModifyCacheCluster` or `ModifyReplicationGroup`, use a value
    /// from this list for the `CacheNodeType` parameter.
    scale_up_modifications: ?[]const []const u8 = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListAllowedNodeTypeModificationsInput, options: CallOptions) !ListAllowedNodeTypeModificationsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ListAllowedNodeTypeModificationsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("elasticache", "ElastiCache", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=ListAllowedNodeTypeModifications&Version=2015-02-02");
    if (input.cache_cluster_id) |v| {
        try body_buf.appendSlice(allocator, "&CacheClusterId=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.replication_group_id) |v| {
        try body_buf.appendSlice(allocator, "&ReplicationGroupId=");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListAllowedNodeTypeModificationsOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "ListAllowedNodeTypeModificationsResult")) break;
            },
            else => {},
        }
    }

    var result: ListAllowedNodeTypeModificationsOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "ScaleDownModifications")) {
                    result.scale_down_modifications = try serde.deserializeNodeTypeList(allocator, &reader, "member");
                } else if (std.mem.eql(u8, e.local, "ScaleUpModifications")) {
                    result.scale_up_modifications = try serde.deserializeNodeTypeList(allocator, &reader, "member");
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
