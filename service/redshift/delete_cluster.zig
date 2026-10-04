const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Cluster = @import("cluster.zig").Cluster;
const serde = @import("serde.zig");

pub const DeleteClusterInput = struct {
    /// The identifier of the cluster to be deleted.
    ///
    /// Constraints:
    ///
    /// * Must contain lowercase characters.
    ///
    /// * Must contain from 1 to 63 alphanumeric characters or hyphens.
    ///
    /// * First character must be a letter.
    ///
    /// * Cannot end with a hyphen or contain two consecutive hyphens.
    cluster_identifier: []const u8,

    /// The identifier of the final snapshot that is to be created immediately
    /// before
    /// deleting the cluster. If this parameter is provided,
    /// *SkipFinalClusterSnapshot* must be `false`.
    ///
    /// Constraints:
    ///
    /// * Must be 1 to 255 alphanumeric characters.
    ///
    /// * First character must be a letter.
    ///
    /// * Cannot end with a hyphen or contain two consecutive hyphens.
    final_cluster_snapshot_identifier: ?[]const u8 = null,

    /// The number of days that a manual snapshot is retained. If the value is -1,
    /// the manual
    /// snapshot is retained indefinitely.
    ///
    /// The value must be either -1 or an integer between 1 and 3,653.
    ///
    /// The default value is -1.
    final_cluster_snapshot_retention_period: ?i32 = null,

    /// Determines whether a final snapshot of the cluster is created before Amazon
    /// Redshift
    /// deletes the cluster. If `true`, a final cluster snapshot is not created. If
    /// `false`, a final cluster snapshot is created before the cluster is
    /// deleted.
    ///
    /// The *FinalClusterSnapshotIdentifier* parameter must be
    /// specified if *SkipFinalClusterSnapshot* is
    /// `false`.
    ///
    /// Default: `false`
    skip_final_cluster_snapshot: ?bool = null,
};

pub const DeleteClusterOutput = struct {
    cluster: ?Cluster = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DeleteClusterInput, options: CallOptions) !DeleteClusterOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "redshift", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DeleteClusterInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("redshift", "Redshift", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=DeleteCluster&Version=2012-12-01");
    try body_buf.appendSlice(allocator, "&ClusterIdentifier=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.cluster_identifier);
    if (input.final_cluster_snapshot_identifier) |v| {
        try body_buf.appendSlice(allocator, "&FinalClusterSnapshotIdentifier=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.final_cluster_snapshot_retention_period) |v| {
        try body_buf.appendSlice(allocator, "&FinalClusterSnapshotRetentionPeriod=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{v}) catch "");
    }
    if (input.skip_final_cluster_snapshot) |v| {
        try body_buf.appendSlice(allocator, "&SkipFinalClusterSnapshot=");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DeleteClusterOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "DeleteClusterResult")) break;
            },
            else => {},
        }
    }

    var result: DeleteClusterOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Cluster")) {
                    result.cluster = try serde.deserializeCluster(allocator, &reader);
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
