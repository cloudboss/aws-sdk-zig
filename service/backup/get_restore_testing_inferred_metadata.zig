const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const GetRestoreTestingInferredMetadataInput = struct {
    /// The account ID of the specified backup vault.
    backup_vault_account_id: ?[]const u8 = null,

    /// The name of a logical container where backups are stored. Backup
    /// vaults are identified by names that are unique to the account used to
    /// create them and the Amazon Web ServicesRegion where they are created.
    /// They consist of letters, numbers, and hyphens.
    backup_vault_name: []const u8,

    /// An Amazon Resource Name (ARN) that uniquely identifies a recovery
    /// point; for example,
    /// `arn:aws:backup:us-east-1:123456789012:recovery-point:1EB3B5E7-9EB0-435A-A80B-108B488B0D45`.
    recovery_point_arn: []const u8,

    pub const json_field_names = .{
        .backup_vault_account_id = "BackupVaultAccountId",
        .backup_vault_name = "BackupVaultName",
        .recovery_point_arn = "RecoveryPointArn",
    };
};

pub const GetRestoreTestingInferredMetadataOutput = struct {
    /// This is a string map of the metadata inferred from the request.
    inferred_metadata: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .inferred_metadata = "InferredMetadata",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetRestoreTestingInferredMetadataInput, options: CallOptions) !GetRestoreTestingInferredMetadataOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "backup", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetRestoreTestingInferredMetadataInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("backup", "Backup", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/restore-testing/inferred-metadata";

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.backup_vault_account_id) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "BackupVaultAccountId=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    if (query_has_prev) try query_buf.appendSlice(allocator, "&");
    try query_buf.appendSlice(allocator, "BackupVaultName=");
    try aws.url.appendUrlEncoded(allocator, &query_buf, input.backup_vault_name);
    query_has_prev = true;
    if (query_has_prev) try query_buf.appendSlice(allocator, "&");
    try query_buf.appendSlice(allocator, "RecoveryPointArn=");
    try aws.url.appendUrlEncoded(allocator, &query_buf, input.recovery_point_arn);
    query_has_prev = true;
    const query = try query_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    request.query = query;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetRestoreTestingInferredMetadataOutput {
    const result: GetRestoreTestingInferredMetadataOutput = try aws.json.parseJsonObject(
        GetRestoreTestingInferredMetadataOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
