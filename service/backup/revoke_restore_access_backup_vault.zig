const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const RevokeRestoreAccessBackupVaultInput = struct {
    /// The name of the source backup vault associated with the restore access
    /// backup vault to be revoked.
    backup_vault_name: []const u8,

    /// A comment explaining the reason for revoking access to the restore access
    /// backup vault.
    requester_comment: ?[]const u8 = null,

    /// The ARN of the restore access backup vault to revoke.
    restore_access_backup_vault_arn: []const u8,

    pub const json_field_names = .{
        .backup_vault_name = "BackupVaultName",
        .requester_comment = "RequesterComment",
        .restore_access_backup_vault_arn = "RestoreAccessBackupVaultArn",
    };
};

pub const RevokeRestoreAccessBackupVaultOutput = struct {};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: RevokeRestoreAccessBackupVaultInput, options: CallOptions) !RevokeRestoreAccessBackupVaultOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: RevokeRestoreAccessBackupVaultInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("backup", "Backup", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/logically-air-gapped-backup-vaults/");
    try path_buf.appendSlice(allocator, input.backup_vault_name);
    try path_buf.appendSlice(allocator, "/restore-access-backup-vaults/");
    try path_buf.appendSlice(allocator, input.restore_access_backup_vault_arn);
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.requester_comment) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "requesterComment=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    const query = try query_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .DELETE;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    request.query = query;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !RevokeRestoreAccessBackupVaultOutput {
    _ = allocator;
    _ = body;
    _ = status;
    _ = headers;
    const result: RevokeRestoreAccessBackupVaultOutput = .{};

    return result;
}
