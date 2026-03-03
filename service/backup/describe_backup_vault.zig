const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const EncryptionKeyType = @import("encryption_key_type.zig").EncryptionKeyType;
const LatestMpaApprovalTeamUpdate = @import("latest_mpa_approval_team_update.zig").LatestMpaApprovalTeamUpdate;
const VaultState = @import("vault_state.zig").VaultState;
const VaultType = @import("vault_type.zig").VaultType;

pub const DescribeBackupVaultInput = struct {
    /// The account ID of the specified backup vault.
    backup_vault_account_id: ?[]const u8 = null,

    /// The name of a logical container where backups are stored. Backup vaults are
    /// identified
    /// by names that are unique to the account used to create them and the Amazon
    /// Web Services
    /// Region where they are created.
    backup_vault_name: []const u8,

    pub const json_field_names = .{
        .backup_vault_account_id = "BackupVaultAccountId",
        .backup_vault_name = "BackupVaultName",
    };
};

pub const DescribeBackupVaultOutput = struct {
    /// An Amazon Resource Name (ARN) that uniquely identifies a backup vault; for
    /// example,
    /// `arn:aws:backup:us-east-1:123456789012:backup-vault:aBackupVault`.
    backup_vault_arn: ?[]const u8 = null,

    /// The name of a logical container where backups are stored. Backup vaults are
    /// identified
    /// by names that are unique to the account used to create them and the Region
    /// where they are
    /// created.
    backup_vault_name: ?[]const u8 = null,

    /// The date and time that a backup vault is created, in Unix format and
    /// Coordinated
    /// Universal Time (UTC). The value of `CreationDate` is accurate to
    /// milliseconds.
    /// For example, the value 1516925490.087 represents Friday, January 26, 2018
    /// 12:11:30.087
    /// AM.
    creation_date: ?i64 = null,

    /// A unique string that identifies the request and allows failed requests to be
    /// retried
    /// without the risk of running the operation twice. This parameter is optional.
    /// If used, this
    /// parameter must contain 1 to 50 alphanumeric or '-_.' characters.
    creator_request_id: ?[]const u8 = null,

    /// The server-side encryption key that is used to protect your backups; for
    /// example,
    /// `arn:aws:kms:us-west-2:111122223333:key/1234abcd-12ab-34cd-56ef-1234567890ab`.
    encryption_key_arn: ?[]const u8 = null,

    /// The type of encryption key used for the backup vault. Valid values are
    /// CUSTOMER_MANAGED_KMS_KEY for customer-managed keys or Amazon Web
    /// Services_OWNED_KMS_KEY for Amazon Web Services-owned keys.
    encryption_key_type: ?EncryptionKeyType = null,

    /// Information about the latest update to the MPA approval team association for
    /// this backup vault.
    latest_mpa_approval_team_update: ?LatestMpaApprovalTeamUpdate = null,

    /// The date and time when Backup Vault Lock configuration cannot be changed or
    /// deleted.
    ///
    /// If you applied Vault Lock to your vault without specifying a lock date, you
    /// can change
    /// any of your Vault Lock settings, or delete Vault Lock from the vault
    /// entirely, at any
    /// time.
    ///
    /// This value is in Unix format, Coordinated Universal Time (UTC), and accurate
    /// to
    /// milliseconds. For example, the value 1516925490.087 represents Friday,
    /// January 26, 2018
    /// 12:11:30.087 AM.
    lock_date: ?i64 = null,

    /// A Boolean that indicates whether Backup Vault Lock is currently protecting
    /// the backup vault. `True` means that Vault Lock causes delete or update
    /// operations on the recovery points stored in the vault to fail.
    locked: ?bool = null,

    /// The Backup Vault Lock setting that specifies the maximum retention period
    /// that the vault retains its recovery points. If this parameter is not
    /// specified, Vault Lock
    /// does not enforce a maximum retention period on the recovery points in the
    /// vault (allowing
    /// indefinite storage).
    ///
    /// If specified, any backup or copy job to the vault must have a lifecycle
    /// policy with a
    /// retention period equal to or shorter than the maximum retention period. If
    /// the job's
    /// retention period is longer than that maximum retention period, then the
    /// vault fails the
    /// backup or copy job, and you should either modify your lifecycle settings or
    /// use a different
    /// vault. Recovery points already stored in the vault prior to Vault Lock are
    /// not
    /// affected.
    max_retention_days: ?i64 = null,

    /// The Backup Vault Lock setting that specifies the minimum retention period
    /// that the vault retains its recovery points. If this
    /// parameter is not specified, Vault Lock will not enforce a minimum retention
    /// period.
    ///
    /// If specified, any backup or copy job to the vault must have a lifecycle
    /// policy with a
    /// retention period equal to or longer than the minimum retention period. If
    /// the job's
    /// retention period is shorter than that minimum retention period, then the
    /// vault fails the
    /// backup or copy job, and you should either modify your lifecycle settings or
    /// use a different
    /// vault. Recovery points already stored in the vault prior to Vault Lock are
    /// not
    /// affected.
    min_retention_days: ?i64 = null,

    /// The ARN of the MPA approval team associated with this backup vault.
    mpa_approval_team_arn: ?[]const u8 = null,

    /// The ARN of the MPA session associated with this backup vault.
    mpa_session_arn: ?[]const u8 = null,

    /// The number of recovery points that are stored in a backup vault.
    ///
    /// Recovery point count value displayed in the console can be an approximation.
    /// Use [
    /// `ListRecoveryPointsByBackupVault`
    /// ](https://docs.aws.amazon.com/aws-backup/latest/devguide/API_ListRecoveryPointsByBackupVault.html) API to obtain the exact
    /// count.
    number_of_recovery_points: ?i64 = null,

    /// The ARN of the source backup vault from which this restore access backup
    /// vault was created.
    source_backup_vault_arn: ?[]const u8 = null,

    /// The current state of the vault.->
    vault_state: ?VaultState = null,

    /// The type of vault described.
    vault_type: ?VaultType = null,

    pub const json_field_names = .{
        .backup_vault_arn = "BackupVaultArn",
        .backup_vault_name = "BackupVaultName",
        .creation_date = "CreationDate",
        .creator_request_id = "CreatorRequestId",
        .encryption_key_arn = "EncryptionKeyArn",
        .encryption_key_type = "EncryptionKeyType",
        .latest_mpa_approval_team_update = "LatestMpaApprovalTeamUpdate",
        .lock_date = "LockDate",
        .locked = "Locked",
        .max_retention_days = "MaxRetentionDays",
        .min_retention_days = "MinRetentionDays",
        .mpa_approval_team_arn = "MpaApprovalTeamArn",
        .mpa_session_arn = "MpaSessionArn",
        .number_of_recovery_points = "NumberOfRecoveryPoints",
        .source_backup_vault_arn = "SourceBackupVaultArn",
        .vault_state = "VaultState",
        .vault_type = "VaultType",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeBackupVaultInput, options: Options) !DescribeBackupVaultOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "backup");

    var response = try client.http_client.sendRequest(&request);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = parseErrorResponse(client.allocator, response.body, response.status) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeBackupVaultInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("backup", "Backup", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var path_buf: std.ArrayList(u8) = .{};
    try path_buf.appendSlice(allocator, "/backup-vaults/");
    try path_buf.appendSlice(allocator, input.backup_vault_name);
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .{};
    var query_has_prev = false;
    if (input.backup_vault_account_id) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "backupVaultAccountId=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    const query = try query_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(host);
    request.method = .GET;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    request.query = query;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeBackupVaultOutput {
    var result: DescribeBackupVaultOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(DescribeBackupVaultOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}

fn parseErrorResponse(allocator: std.mem.Allocator, body: []const u8, status: u16) !ServiceError {
    const error_code = blk: {
        const type_str = aws.json.findJsonValue(body, "__type") orelse break :blk @as([]const u8, "Unknown");
        if (std.mem.lastIndexOfScalar(u8, type_str, '#')) |idx| {
            break :blk type_str[idx + 1 ..];
        }
        break :blk type_str;
    };
    const error_message = aws.json.findJsonValue(body, "message") orelse aws.json.findJsonValue(body, "Message") orelse "";
    var arena = std.heap.ArenaAllocator.init(allocator);
    errdefer arena.deinit();
    const arena_alloc = arena.allocator();
    const owned_message = try arena_alloc.dupe(u8, error_message);
    const owned_request_id = try arena_alloc.dupe(u8, "");

    if (std.mem.eql(u8, error_code, "AlreadyExistsException")) {
        return .{ .arena = arena, .kind = .{ .already_exists_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ConflictException")) {
        return .{ .arena = arena, .kind = .{ .conflict_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "DependencyFailureException")) {
        return .{ .arena = arena, .kind = .{ .dependency_failure_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidParameterValueException")) {
        return .{ .arena = arena, .kind = .{ .invalid_parameter_value_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidRequestException")) {
        return .{ .arena = arena, .kind = .{ .invalid_request_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidResourceStateException")) {
        return .{ .arena = arena, .kind = .{ .invalid_resource_state_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "LimitExceededException")) {
        return .{ .arena = arena, .kind = .{ .limit_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "MissingParameterValueException")) {
        return .{ .arena = arena, .kind = .{ .missing_parameter_value_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .resource_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ServiceUnavailableException")) {
        return .{ .arena = arena, .kind = .{ .service_unavailable_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }

    const owned_code = try arena_alloc.dupe(u8, error_code);
    return .{ .arena = arena, .kind = .{ .unknown = .{
        .code = owned_code,
        .message = owned_message,
        .request_id = owned_request_id,
        .http_status = status,
    } } };
}
