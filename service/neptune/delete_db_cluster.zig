const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const DBCluster = @import("db_cluster.zig").DBCluster;
const serde = @import("serde.zig");

pub const DeleteDBClusterInput = struct {
    /// The DB cluster identifier for the DB cluster to be deleted. This parameter
    /// isn't
    /// case-sensitive.
    ///
    /// Constraints:
    ///
    /// * Must match an existing DBClusterIdentifier.
    db_cluster_identifier: []const u8,

    /// The DB cluster snapshot identifier of the new DB cluster snapshot created
    /// when
    /// `SkipFinalSnapshot` is set to `false`.
    ///
    /// Specifying this parameter and also setting the `SkipFinalSnapshot` parameter
    /// to true results in an error.
    ///
    /// Constraints:
    ///
    /// * Must be 1 to 255 letters, numbers, or hyphens.
    ///
    /// * First character must be a letter
    ///
    /// * Cannot end with a hyphen or contain two consecutive hyphens
    final_db_snapshot_identifier: ?[]const u8 = null,

    /// Determines whether a final DB cluster snapshot is created before the DB
    /// cluster is
    /// deleted. If `true` is specified, no DB cluster snapshot is created. If
    /// `false` is specified, a DB cluster snapshot is created before the DB cluster
    /// is
    /// deleted.
    ///
    /// You must specify a `FinalDBSnapshotIdentifier` parameter if
    /// `SkipFinalSnapshot` is `false`.
    ///
    /// Default: `false`
    skip_final_snapshot: ?bool = null,
};

pub const DeleteDBClusterOutput = struct {
    db_cluster: ?DBCluster = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DeleteDBClusterInput, options: CallOptions) !DeleteDBClusterOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DeleteDBClusterInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("rds", "Neptune", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=DeleteDBCluster&Version=2014-10-31");
    try body_buf.appendSlice(allocator, "&DBClusterIdentifier=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.db_cluster_identifier);
    if (input.final_db_snapshot_identifier) |v| {
        try body_buf.appendSlice(allocator, "&FinalDBSnapshotIdentifier=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.skip_final_snapshot) |v| {
        try body_buf.appendSlice(allocator, "&SkipFinalSnapshot=");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DeleteDBClusterOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "DeleteDBClusterResult")) break;
            },
            else => {},
        }
    }

    var result: DeleteDBClusterOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "DBCluster")) {
                    result.db_cluster = try serde.deserializeDBCluster(allocator, &reader);
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
