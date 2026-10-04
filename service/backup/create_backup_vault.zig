const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const CreateBackupVaultInput = struct {
    /// The name of a logical container where backups are stored. Backup vaults are
    /// identified
    /// by names that are unique to the account used to create them and the Amazon
    /// Web Services
    /// Region where they are created. They consist of letters, numbers, and
    /// hyphens.
    backup_vault_name: []const u8,

    /// The tags to assign to the backup vault.
    backup_vault_tags: ?[]const aws.map.StringMapEntry = null,

    /// A unique string that identifies the request and allows failed requests to be
    /// retried
    /// without the risk of running the operation twice. This parameter is optional.
    ///
    /// If used, this parameter must contain 1 to 50 alphanumeric or '-_.'
    /// characters.
    creator_request_id: ?[]const u8 = null,

    /// The server-side encryption key that is used to protect your backups; for
    /// example,
    /// `arn:aws:kms:us-west-2:111122223333:key/1234abcd-12ab-34cd-56ef-1234567890ab`.
    encryption_key_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .backup_vault_name = "BackupVaultName",
        .backup_vault_tags = "BackupVaultTags",
        .creator_request_id = "CreatorRequestId",
        .encryption_key_arn = "EncryptionKeyArn",
    };
};

pub const CreateBackupVaultOutput = struct {
    /// An Amazon Resource Name (ARN) that uniquely identifies a backup vault; for
    /// example,
    /// `arn:aws:backup:us-east-1:123456789012:backup-vault:aBackupVault`.
    backup_vault_arn: ?[]const u8 = null,

    /// The name of a logical container where backups are stored. Backup vaults are
    /// identified
    /// by names that are unique to the account used to create them and the Region
    /// where they are
    /// created. They consist of lowercase letters, numbers, and hyphens.
    backup_vault_name: ?[]const u8 = null,

    /// The date and time a backup vault is created, in Unix format and Coordinated
    /// Universal
    /// Time (UTC). The value of `CreationDate` is accurate to milliseconds. For
    /// example, the value 1516925490.087 represents Friday, January 26, 2018
    /// 12:11:30.087
    /// AM.
    creation_date: ?i64 = null,

    pub const json_field_names = .{
        .backup_vault_arn = "BackupVaultArn",
        .backup_vault_name = "BackupVaultName",
        .creation_date = "CreationDate",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateBackupVaultInput, options: CallOptions) !CreateBackupVaultOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateBackupVaultInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("backup", "Backup", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/backup-vaults/");
    try path_buf.appendSlice(allocator, input.backup_vault_name);
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

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
    if (input.encryption_key_arn) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"EncryptionKeyArn\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateBackupVaultOutput {
    const result: CreateBackupVaultOutput = try aws.json.parseJsonObject(
        CreateBackupVaultOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
