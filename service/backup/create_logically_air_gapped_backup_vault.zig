const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const VaultState = @import("vault_state.zig").VaultState;

pub const CreateLogicallyAirGappedBackupVaultInput = struct {
    /// The name of a logical container where backups are stored. Logically
    /// air-gapped
    /// backup vaults are identified by names that are unique to the account used to
    /// create
    /// them and the Region where they are created.
    backup_vault_name: []const u8,

    /// The tags to assign to the vault.
    backup_vault_tags: ?[]const aws.map.StringMapEntry = null,

    /// The ID of the creation request.
    ///
    /// This parameter is optional. If used, this parameter must contain
    /// 1 to 50 alphanumeric or '-_.' characters.
    creator_request_id: ?[]const u8 = null,

    /// The ARN of the customer-managed KMS key to use for encrypting the logically
    /// air-gapped backup vault. If not specified, the vault will be encrypted with
    /// an Amazon Web Services-owned key managed by Amazon Web Services Backup.
    encryption_key_arn: ?[]const u8 = null,

    /// The maximum retention period that the vault retains its recovery points.
    max_retention_days: i64,

    /// This setting specifies the minimum retention period
    /// that the vault retains its recovery points.
    ///
    /// The minimum value accepted is 7 days.
    min_retention_days: i64,

    pub const json_field_names = .{
        .backup_vault_name = "BackupVaultName",
        .backup_vault_tags = "BackupVaultTags",
        .creator_request_id = "CreatorRequestId",
        .encryption_key_arn = "EncryptionKeyArn",
        .max_retention_days = "MaxRetentionDays",
        .min_retention_days = "MinRetentionDays",
    };
};

pub const CreateLogicallyAirGappedBackupVaultOutput = struct {
    /// The ARN (Amazon Resource Name) of the vault.
    backup_vault_arn: ?[]const u8 = null,

    /// The name of a logical container where backups are stored. Logically
    /// air-gapped
    /// backup vaults are identified by names that are unique to the account used to
    /// create
    /// them and the Region where they are created.
    backup_vault_name: ?[]const u8 = null,

    /// The date and time when the vault was created.
    ///
    /// This value is in Unix format, Coordinated Universal Time (UTC), and accurate
    /// to
    /// milliseconds. For example, the value 1516925490.087 represents Friday,
    /// January 26, 2018
    /// 12:11:30.087 AM.
    creation_date: ?i64 = null,

    /// The current state of the vault.
    vault_state: ?VaultState = null,

    pub const json_field_names = .{
        .backup_vault_arn = "BackupVaultArn",
        .backup_vault_name = "BackupVaultName",
        .creation_date = "CreationDate",
        .vault_state = "VaultState",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateLogicallyAirGappedBackupVaultInput, options: CallOptions) !CreateLogicallyAirGappedBackupVaultOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateLogicallyAirGappedBackupVaultInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("backup", "Backup", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/logically-air-gapped-backup-vaults/");
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
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"MaxRetentionDays\":");
    try aws.json.writeValue(@TypeOf(input.max_retention_days), input.max_retention_days, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"MinRetentionDays\":");
    try aws.json.writeValue(@TypeOf(input.min_retention_days), input.min_retention_days, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateLogicallyAirGappedBackupVaultOutput {
    var result: CreateLogicallyAirGappedBackupVaultOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CreateLogicallyAirGappedBackupVaultOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
