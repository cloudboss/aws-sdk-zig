const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const DBInstanceAutomatedBackup = @import("db_instance_automated_backup.zig").DBInstanceAutomatedBackup;
const serde = @import("serde.zig");

pub const DeleteDBInstanceAutomatedBackupInput = struct {
    /// The Amazon Resource Name (ARN) of the automated backups to delete, for
    /// example,
    /// `arn:aws:rds:us-east-1:123456789012:auto-backup:ab-L2IJCEXJP7XQ7HOJ4SIEXAMPLE`.
    ///
    /// This setting doesn't apply to RDS Custom.
    db_instance_automated_backups_arn: ?[]const u8 = null,

    /// The identifier for the source DB instance, which can't be changed and which
    /// is unique to an Amazon Web Services Region.
    dbi_resource_id: ?[]const u8 = null,
};

pub const DeleteDBInstanceAutomatedBackupOutput = struct {
    db_instance_automated_backup: ?DBInstanceAutomatedBackup = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DeleteDBInstanceAutomatedBackupInput, options: CallOptions) !DeleteDBInstanceAutomatedBackupOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DeleteDBInstanceAutomatedBackupInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("rds", "RDS", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=DeleteDBInstanceAutomatedBackup&Version=2014-10-31");
    if (input.db_instance_automated_backups_arn) |v| {
        try body_buf.appendSlice(allocator, "&DBInstanceAutomatedBackupsArn=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.dbi_resource_id) |v| {
        try body_buf.appendSlice(allocator, "&DbiResourceId=");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DeleteDBInstanceAutomatedBackupOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "DeleteDBInstanceAutomatedBackupResult")) break;
            },
            else => {},
        }
    }

    var result: DeleteDBInstanceAutomatedBackupOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "DBInstanceAutomatedBackup")) {
                    result.db_instance_automated_backup = try serde.deserializeDBInstanceAutomatedBackup(allocator, &reader);
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
