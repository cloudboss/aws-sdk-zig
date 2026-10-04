const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const DBInstance = @import("db_instance.zig").DBInstance;
const serde = @import("serde.zig");

pub const DeleteDBInstanceInput = struct {
    /// The DB instance identifier for the DB instance to be deleted. This parameter
    /// isn't case-sensitive.
    ///
    /// Constraints:
    ///
    /// * Must match the name of an existing DB instance.
    db_instance_identifier: []const u8,

    /// Specifies whether to remove automated backups immediately after the DB
    /// instance is deleted. This parameter isn't case-sensitive. The default is to
    /// remove automated backups immediately after the DB instance is deleted.
    delete_automated_backups: ?bool = null,

    /// The `DBSnapshotIdentifier` of the new `DBSnapshot` created when the
    /// `SkipFinalSnapshot` parameter is disabled.
    ///
    /// If you enable this parameter and also enable SkipFinalShapshot, the command
    /// results in an error.
    ///
    /// This setting doesn't apply to RDS Custom.
    ///
    /// Constraints:
    ///
    /// * Must be 1 to 255 letters or numbers.
    /// * First character must be a letter.
    /// * Can't end with a hyphen or contain two consecutive hyphens.
    /// * Can't be specified when deleting a read replica.
    final_db_snapshot_identifier: ?[]const u8 = null,

    /// Specifies whether to skip the creation of a final DB snapshot before
    /// deleting the instance. If you enable this parameter, RDS doesn't create a DB
    /// snapshot. If you don't enable this parameter, RDS creates a DB snapshot
    /// before the DB instance is deleted. By default, skip isn't enabled, and the
    /// DB snapshot is created.
    ///
    /// If you don't enable this parameter, you must specify the
    /// `FinalDBSnapshotIdentifier` parameter.
    ///
    /// When a DB instance is in a failure state and has a status of `failed`,
    /// `incompatible-restore`, or `incompatible-network`, RDS can delete the
    /// instance only if you enable this parameter.
    ///
    /// If you delete a read replica or an RDS Custom instance, you must enable this
    /// setting.
    ///
    /// This setting is required for RDS Custom.
    skip_final_snapshot: ?bool = null,
};

pub const DeleteDBInstanceOutput = struct {
    db_instance: ?DBInstance = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DeleteDBInstanceInput, options: CallOptions) !DeleteDBInstanceOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DeleteDBInstanceInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("rds", "RDS", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=DeleteDBInstance&Version=2014-10-31");
    try body_buf.appendSlice(allocator, "&DBInstanceIdentifier=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.db_instance_identifier);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DeleteDBInstanceOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "DeleteDBInstanceResult")) break;
            },
            else => {},
        }
    }

    var result: DeleteDBInstanceOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "DBInstance")) {
                    result.db_instance = try serde.deserializeDBInstance(allocator, &reader);
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
