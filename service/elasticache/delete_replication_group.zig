const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ReplicationGroup = @import("replication_group.zig").ReplicationGroup;
const serde = @import("serde.zig");

pub const DeleteReplicationGroupInput = struct {
    /// The name of a final node group (shard) snapshot. ElastiCache creates the
    /// snapshot from
    /// the primary node in the cluster, rather than one of the replicas; this is to
    /// ensure that
    /// it captures the freshest data. After the final snapshot is taken, the
    /// replication group
    /// is immediately deleted.
    final_snapshot_identifier: ?[]const u8 = null,

    /// The identifier for the cluster to be deleted. This parameter is not case
    /// sensitive.
    replication_group_id: []const u8,

    /// If set to `true`, all of the read replicas are deleted, but the primary
    /// node is retained.
    retain_primary_cluster: ?bool = null,
};

pub const DeleteReplicationGroupOutput = struct {
    replication_group: ?ReplicationGroup = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DeleteReplicationGroupInput, options: CallOptions) !DeleteReplicationGroupOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DeleteReplicationGroupInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("elasticache", "ElastiCache", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=DeleteReplicationGroup&Version=2015-02-02");
    if (input.final_snapshot_identifier) |v| {
        try body_buf.appendSlice(allocator, "&FinalSnapshotIdentifier=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    try body_buf.appendSlice(allocator, "&ReplicationGroupId=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.replication_group_id);
    if (input.retain_primary_cluster) |v| {
        try body_buf.appendSlice(allocator, "&RetainPrimaryCluster=");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DeleteReplicationGroupOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "DeleteReplicationGroupResult")) break;
            },
            else => {},
        }
    }

    var result: DeleteReplicationGroupOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "ReplicationGroup")) {
                    result.replication_group = try serde.deserializeReplicationGroup(allocator, &reader);
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
