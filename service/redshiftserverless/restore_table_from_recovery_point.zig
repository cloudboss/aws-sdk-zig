const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const TableRestoreStatus = @import("table_restore_status.zig").TableRestoreStatus;

pub const RestoreTableFromRecoveryPointInput = struct {
    /// Indicates whether name identifiers for database, schema, and table are case
    /// sensitive. If true, the names are case sensitive. If false, the names are
    /// not case sensitive. The default is false.
    activate_case_sensitive_identifier: ?bool = null,

    /// Namespace of the recovery point to restore from.
    namespace_name: []const u8,

    /// The name of the table to create from the restore operation.
    new_table_name: []const u8,

    /// The ID of the recovery point to restore the table from.
    recovery_point_id: []const u8,

    /// The name of the source database that contains the table being restored.
    source_database_name: []const u8,

    /// The name of the source schema that contains the table being restored.
    source_schema_name: ?[]const u8 = null,

    /// The name of the source table being restored.
    source_table_name: []const u8,

    /// The name of the database to restore the table to.
    target_database_name: ?[]const u8 = null,

    /// The name of the schema to restore the table to.
    target_schema_name: ?[]const u8 = null,

    /// The workgroup to restore the table to.
    workgroup_name: []const u8,

    pub const json_field_names = .{
        .activate_case_sensitive_identifier = "activateCaseSensitiveIdentifier",
        .namespace_name = "namespaceName",
        .new_table_name = "newTableName",
        .recovery_point_id = "recoveryPointId",
        .source_database_name = "sourceDatabaseName",
        .source_schema_name = "sourceSchemaName",
        .source_table_name = "sourceTableName",
        .target_database_name = "targetDatabaseName",
        .target_schema_name = "targetSchemaName",
        .workgroup_name = "workgroupName",
    };
};

pub const RestoreTableFromRecoveryPointOutput = struct {
    table_restore_status: ?TableRestoreStatus = null,

    pub const json_field_names = .{
        .table_restore_status = "tableRestoreStatus",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: RestoreTableFromRecoveryPointInput, options: CallOptions) !RestoreTableFromRecoveryPointOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "redshift-serverless", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: RestoreTableFromRecoveryPointInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("redshift-serverless", "Redshift Serverless", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "RedshiftServerless.RestoreTableFromRecoveryPoint");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !RestoreTableFromRecoveryPointOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(RestoreTableFromRecoveryPointOutput, body, allocator);
}
