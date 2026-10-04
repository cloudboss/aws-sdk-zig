const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Snapshot = @import("snapshot.zig").Snapshot;
const serde = @import("serde.zig");

pub const DescribeSnapshotsInput = struct {
    /// A user-supplied cluster identifier. If this parameter is specified, only
    /// snapshots
    /// associated with that specific cluster are described.
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
    /// Default: 50
    ///
    /// Constraints: minimum 20; maximum 50.
    max_records: ?i32 = null,

    /// A user-supplied replication group identifier. If this parameter is
    /// specified, only
    /// snapshots associated with that specific replication group are described.
    replication_group_id: ?[]const u8 = null,

    /// A Boolean value which if true, the node group (shard) configuration is
    /// included in the
    /// snapshot description.
    show_node_group_config: ?bool = null,

    /// A user-supplied name of the snapshot. If this parameter is specified, only
    /// this
    /// snapshot are described.
    snapshot_name: ?[]const u8 = null,

    /// If set to `system`, the output shows snapshots that were automatically
    /// created by ElastiCache. If set to `user` the output shows snapshots that
    /// were
    /// manually created. If omitted, the output shows both automatically and
    /// manually created
    /// snapshots.
    snapshot_source: ?[]const u8 = null,
};

pub const DescribeSnapshotsOutput = struct {
    /// An optional marker returned from a prior request. Use this marker for
    /// pagination of
    /// results from this operation. If this parameter is specified, the response
    /// includes only
    /// records beyond the marker, up to the value specified by `MaxRecords`.
    marker: ?[]const u8 = null,

    /// A list of snapshots. Each item in the list contains detailed information
    /// about one
    /// snapshot.
    snapshots: ?[]const Snapshot = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeSnapshotsInput, options: CallOptions) !DescribeSnapshotsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeSnapshotsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("elasticache", "ElastiCache", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=DescribeSnapshots&Version=2015-02-02");
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
    if (input.replication_group_id) |v| {
        try body_buf.appendSlice(allocator, "&ReplicationGroupId=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.show_node_group_config) |v| {
        try body_buf.appendSlice(allocator, "&ShowNodeGroupConfig=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, if (v) "true" else "false");
    }
    if (input.snapshot_name) |v| {
        try body_buf.appendSlice(allocator, "&SnapshotName=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.snapshot_source) |v| {
        try body_buf.appendSlice(allocator, "&SnapshotSource=");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeSnapshotsOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "DescribeSnapshotsResult")) break;
            },
            else => {},
        }
    }

    var result: DescribeSnapshotsOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Marker")) {
                    result.marker = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Snapshots")) {
                    result.snapshots = try serde.deserializeSnapshotList(allocator, &reader, "Snapshot");
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
