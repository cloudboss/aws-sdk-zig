const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const DBCluster = @import("db_cluster.zig").DBCluster;
const serde = @import("serde.zig");

pub const DeleteDBClusterInput = struct {
    /// The DB cluster identifier for the DB cluster to be deleted. This parameter
    /// isn't case-sensitive.
    ///
    /// Constraints:
    ///
    /// * Must match an existing DBClusterIdentifier.
    db_cluster_identifier: []const u8,

    /// Specifies whether to remove automated backups immediately after the DB
    /// cluster is deleted. This parameter isn't case-sensitive. The default is to
    /// remove automated backups immediately after the DB cluster is deleted, unless
    /// the Amazon Web Services Backup policy specifies a point-in-time restore
    /// rule.
    delete_automated_backups: ?bool = null,

    /// The DB cluster snapshot identifier of the new DB cluster snapshot created
    /// when `SkipFinalSnapshot` is disabled.
    ///
    /// If you specify this parameter and also skip the creation of a final DB
    /// cluster snapshot with the `SkipFinalShapshot` parameter, the request results
    /// in an error.
    ///
    /// Constraints:
    ///
    /// * Must be 1 to 255 letters, numbers, or hyphens.
    /// * First character must be a letter
    /// * Can't end with a hyphen or contain two consecutive hyphens
    final_db_snapshot_identifier: ?[]const u8 = null,

    /// Specifies whether to skip the creation of a final DB cluster snapshot before
    /// RDS deletes the DB cluster. If you set this value to `true`, RDS doesn't
    /// create a final DB cluster snapshot. If you set this value to `false` or
    /// don't specify it, RDS creates a DB cluster snapshot before it deletes the DB
    /// cluster. By default, this parameter is disabled, so RDS creates a final DB
    /// cluster snapshot.
    ///
    /// If `SkipFinalSnapshot` is disabled, you must specify a value for the
    /// `FinalDBSnapshotIdentifier` parameter.
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
    const endpoint = try config.getEndpointForService("rds", "RDS", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=DeleteDBCluster&Version=2014-10-31");
    try body_buf.appendSlice(allocator, "&DBClusterIdentifier=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.db_cluster_identifier);
    if (input.delete_automated_backups) |v| {
        try body_buf.appendSlice(allocator, "&DeleteAutomatedBackups=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, if (v) "true" else "false");
    }
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
