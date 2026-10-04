const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const TenantDatabase = @import("tenant_database.zig").TenantDatabase;
const serde = @import("serde.zig");

pub const DeleteTenantDatabaseInput = struct {
    /// The user-supplied identifier for the DB instance that contains the tenant
    /// database that you want to delete.
    db_instance_identifier: []const u8,

    /// The `DBSnapshotIdentifier` of the new `DBSnapshot` created when the
    /// `SkipFinalSnapshot` parameter is disabled.
    ///
    /// If you enable this parameter and also enable `SkipFinalShapshot`, the
    /// command results in an error.
    final_db_snapshot_identifier: ?[]const u8 = null,

    /// Specifies whether to skip the creation of a final DB snapshot before
    /// removing the tenant database from your DB instance. If you enable this
    /// parameter, RDS doesn't create a DB snapshot. If you don't enable this
    /// parameter, RDS creates a DB snapshot before it deletes the tenant database.
    /// By default, RDS doesn't skip the final snapshot. If you don't enable this
    /// parameter, you must specify the `FinalDBSnapshotIdentifier` parameter.
    skip_final_snapshot: ?bool = null,

    /// The user-supplied name of the tenant database that you want to remove from
    /// your DB instance. Amazon RDS deletes the tenant database with this name.
    /// This parameter isn’t case-sensitive.
    tenant_db_name: []const u8,
};

pub const DeleteTenantDatabaseOutput = struct {
    tenant_database: ?TenantDatabase = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DeleteTenantDatabaseInput, options: CallOptions) !DeleteTenantDatabaseOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DeleteTenantDatabaseInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("rds", "RDS", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=DeleteTenantDatabase&Version=2014-10-31");
    try body_buf.appendSlice(allocator, "&DBInstanceIdentifier=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.db_instance_identifier);
    if (input.final_db_snapshot_identifier) |v| {
        try body_buf.appendSlice(allocator, "&FinalDBSnapshotIdentifier=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.skip_final_snapshot) |v| {
        try body_buf.appendSlice(allocator, "&SkipFinalSnapshot=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, if (v) "true" else "false");
    }
    try body_buf.appendSlice(allocator, "&TenantDBName=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.tenant_db_name);

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DeleteTenantDatabaseOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "DeleteTenantDatabaseResult")) break;
            },
            else => {},
        }
    }

    var result: DeleteTenantDatabaseOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "TenantDatabase")) {
                    result.tenant_database = try serde.deserializeTenantDatabase(allocator, &reader);
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
