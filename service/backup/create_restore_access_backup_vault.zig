const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const VaultState = @import("vault_state.zig").VaultState;

pub const CreateRestoreAccessBackupVaultInput = struct {
    /// The name of the backup vault to associate with an MPA approval team.
    backup_vault_name: ?[]const u8 = null,

    /// Optional tags to assign to the restore access backup vault.
    backup_vault_tags: ?[]const aws.map.StringMapEntry = null,

    /// A unique string that identifies the request and allows failed requests to be
    /// retried without the risk of executing the operation twice.
    creator_request_id: ?[]const u8 = null,

    /// A comment explaining the reason for requesting restore access to the backup
    /// vault.
    requester_comment: ?[]const u8 = null,

    /// The ARN of the source backup vault containing the recovery points to which
    /// temporary access is requested.
    source_backup_vault_arn: []const u8,

    pub const json_field_names = .{
        .backup_vault_name = "BackupVaultName",
        .backup_vault_tags = "BackupVaultTags",
        .creator_request_id = "CreatorRequestId",
        .requester_comment = "RequesterComment",
        .source_backup_vault_arn = "SourceBackupVaultArn",
    };
};

pub const CreateRestoreAccessBackupVaultOutput = struct {
    /// >The date and time when the restore access backup vault was created, in Unix
    /// format and Coordinated Universal Time
    creation_date: ?i64 = null,

    /// The ARN that uniquely identifies the created restore access backup vault.
    restore_access_backup_vault_arn: ?[]const u8 = null,

    /// The name of the created restore access backup vault.
    restore_access_backup_vault_name: ?[]const u8 = null,

    /// The current state of the restore access backup vault.
    vault_state: ?VaultState = null,

    pub const json_field_names = .{
        .creation_date = "CreationDate",
        .restore_access_backup_vault_arn = "RestoreAccessBackupVaultArn",
        .restore_access_backup_vault_name = "RestoreAccessBackupVaultName",
        .vault_state = "VaultState",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateRestoreAccessBackupVaultInput, options: CallOptions) !CreateRestoreAccessBackupVaultOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateRestoreAccessBackupVaultInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("backup", "Backup", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/restore-access-backup-vaults";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.backup_vault_name) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"BackupVaultName\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.backup_vault_tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"BackupVaultTags\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.creator_request_id) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"CreatorRequestId\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.requester_comment) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"RequesterComment\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"SourceBackupVaultArn\":");
    try aws.json.writeValue(@TypeOf(input.source_backup_vault_arn), input.source_backup_vault_arn, allocator, &body_buf);
    has_prev = true;

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .PUT;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateRestoreAccessBackupVaultOutput {
    var result: CreateRestoreAccessBackupVaultOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CreateRestoreAccessBackupVaultOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
