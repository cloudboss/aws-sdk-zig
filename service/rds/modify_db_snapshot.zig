const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const DBSnapshot = @import("db_snapshot.zig").DBSnapshot;
const serde = @import("serde.zig");

pub const ModifyDBSnapshotInput = struct {
    /// The identifier of the DB snapshot to modify.
    db_snapshot_identifier: []const u8,

    /// The engine version to upgrade the DB snapshot to.
    ///
    /// The following are the database engines and engine versions that are
    /// available when you upgrade a DB snapshot.
    ///
    /// **MariaDB**
    ///
    /// For the list of engine versions that are available for upgrading a DB
    /// snapshot, see [ Upgrading a MariaDB DB snapshot engine
    /// version](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/mariadb-upgrade-snapshot.html) in the *Amazon RDS User Guide.*
    ///
    /// **MySQL**
    ///
    /// For the list of engine versions that are available for upgrading a DB
    /// snapshot, see [ Upgrading a MySQL DB snapshot engine
    /// version](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/mysql-upgrade-snapshot.html) in the *Amazon RDS User Guide.*
    ///
    /// **Oracle**
    ///
    /// * `21.0.0.0.ru-2025-04.rur-2025-04.r1` (supported for
    ///   21.0.0.0.ru-2022-01.rur-2022-01.r1, 21.0.0.0.ru-2022-04.rur-2022-04.r1,
    ///   21.0.0.0.ru-2022-07.rur-2022-07.r1, 21.0.0.0.ru-2022-10.rur-2022-10.r1,
    ///   21.0.0.0.ru-2023-01.rur-2023-01.r1 and 21.0.0.0.ru-2023-01.rur-2023-01.r2
    ///   DB snapshots)
    /// * `19.0.0.0.ru-2025-04.rur-2025-04.r1` (supported for
    ///   19.0.0.0.ru-2019-07.rur-2019-07.r1, 19.0.0.0.ru-2019-10.rur-2019-10.r1 and
    ///   0.0.0.ru-2020-01.rur-2020-01.r1 DB snapshots)
    /// * `19.0.0.0.ru-2022-01.rur-2022-01.r1` (supported for 12.2.0.1 DB snapshots)
    /// * `19.0.0.0.ru-2022-07.rur-2022-07.r1` (supported for 12.1.0.2 DB snapshots)
    /// * `12.1.0.2.v8` (supported for 12.1.0.1 DB snapshots)
    /// * `11.2.0.4.v12` (supported for 11.2.0.2 DB snapshots)
    /// * `11.2.0.4.v11` (supported for 11.2.0.3 DB snapshots)
    ///
    /// **PostgreSQL**
    ///
    /// For the list of engine versions that are available for upgrading a DB
    /// snapshot, see [ Upgrading a PostgreSQL DB snapshot engine
    /// version](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/USER_UpgradeDBSnapshot.PostgreSQL.html) in the *Amazon RDS User Guide.*
    engine_version: ?[]const u8 = null,

    /// The option group to identify with the upgraded DB snapshot.
    ///
    /// You can specify this parameter when you upgrade an Oracle DB snapshot. The
    /// same option group considerations apply when upgrading a DB snapshot as when
    /// upgrading a DB instance. For more information, see [Option group
    /// considerations](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/USER_UpgradeDBInstance.Oracle.html#USER_UpgradeDBInstance.Oracle.OGPG.OG) in the *Amazon RDS User Guide.*
    option_group_name: ?[]const u8 = null,
};

pub const ModifyDBSnapshotOutput = struct {
    db_snapshot: ?DBSnapshot = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ModifyDBSnapshotInput, options: CallOptions) !ModifyDBSnapshotOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ModifyDBSnapshotInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("rds", "RDS", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=ModifyDBSnapshot&Version=2014-10-31");
    try body_buf.appendSlice(allocator, "&DBSnapshotIdentifier=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.db_snapshot_identifier);
    if (input.engine_version) |v| {
        try body_buf.appendSlice(allocator, "&EngineVersion=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.option_group_name) |v| {
        try body_buf.appendSlice(allocator, "&OptionGroupName=");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ModifyDBSnapshotOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "ModifyDBSnapshotResult")) break;
            },
            else => {},
        }
    }

    var result: ModifyDBSnapshotOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "DBSnapshot")) {
                    result.db_snapshot = try serde.deserializeDBSnapshot(allocator, &reader);
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
