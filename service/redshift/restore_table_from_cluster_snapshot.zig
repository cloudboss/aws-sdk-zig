const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const TableRestoreStatus = @import("table_restore_status.zig").TableRestoreStatus;
const serde = @import("serde.zig");

pub const RestoreTableFromClusterSnapshotInput = struct {
    /// The identifier of the Amazon Redshift cluster to restore the table to.
    cluster_identifier: []const u8,

    /// Indicates whether name identifiers for database, schema, and table are case
    /// sensitive.
    /// If `true`, the names are case sensitive.
    /// If `false` (default), the names are not case sensitive.
    enable_case_sensitive_identifier: ?bool = null,

    /// The name of the table to create as a result of the current request.
    new_table_name: []const u8,

    /// The identifier of the snapshot to restore the table from. This snapshot must
    /// have
    /// been created from the Amazon Redshift cluster specified by the
    /// `ClusterIdentifier` parameter.
    snapshot_identifier: []const u8,

    /// The name of the source database that contains the table to restore from.
    source_database_name: []const u8,

    /// The name of the source schema that contains the table to restore from. If
    /// you do
    /// not specify a `SourceSchemaName` value, the default is
    /// `public`.
    source_schema_name: ?[]const u8 = null,

    /// The name of the source table to restore from.
    source_table_name: []const u8,

    /// The name of the database to restore the table to.
    target_database_name: ?[]const u8 = null,

    /// The name of the schema to restore the table to.
    target_schema_name: ?[]const u8 = null,
};

pub const RestoreTableFromClusterSnapshotOutput = struct {
    table_restore_status: ?TableRestoreStatus = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: RestoreTableFromClusterSnapshotInput, options: CallOptions) !RestoreTableFromClusterSnapshotOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: RestoreTableFromClusterSnapshotInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("redshift", "Redshift", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=RestoreTableFromClusterSnapshot&Version=2012-12-01");
    try body_buf.appendSlice(allocator, "&ClusterIdentifier=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.cluster_identifier);
    if (input.enable_case_sensitive_identifier) |v| {
        try body_buf.appendSlice(allocator, "&EnableCaseSensitiveIdentifier=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, if (v) "true" else "false");
    }
    try body_buf.appendSlice(allocator, "&NewTableName=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.new_table_name);
    try body_buf.appendSlice(allocator, "&SnapshotIdentifier=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.snapshot_identifier);
    try body_buf.appendSlice(allocator, "&SourceDatabaseName=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.source_database_name);
    if (input.source_schema_name) |v| {
        try body_buf.appendSlice(allocator, "&SourceSchemaName=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    try body_buf.appendSlice(allocator, "&SourceTableName=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.source_table_name);
    if (input.target_database_name) |v| {
        try body_buf.appendSlice(allocator, "&TargetDatabaseName=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.target_schema_name) |v| {
        try body_buf.appendSlice(allocator, "&TargetSchemaName=");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !RestoreTableFromClusterSnapshotOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "RestoreTableFromClusterSnapshotResult")) break;
            },
            else => {},
        }
    }

    var result: RestoreTableFromClusterSnapshotOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "TableRestoreStatus")) {
                    result.table_restore_status = try serde.deserializeTableRestoreStatus(allocator, &reader);
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
