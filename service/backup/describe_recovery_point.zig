const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const CalculatedLifecycle = @import("calculated_lifecycle.zig").CalculatedLifecycle;
const RecoveryPointCreator = @import("recovery_point_creator.zig").RecoveryPointCreator;
const EncryptionKeyType = @import("encryption_key_type.zig").EncryptionKeyType;
const IndexStatus = @import("index_status.zig").IndexStatus;
const Lifecycle = @import("lifecycle.zig").Lifecycle;
const ScanResult = @import("scan_result.zig").ScanResult;
const RecoveryPointStatus = @import("recovery_point_status.zig").RecoveryPointStatus;
const StorageClass = @import("storage_class.zig").StorageClass;
const VaultType = @import("vault_type.zig").VaultType;

pub const DescribeRecoveryPointInput = struct {
    /// The account ID of the specified backup vault.
    backup_vault_account_id: ?[]const u8 = null,

    /// The name of a logical container where backups are stored. Backup vaults are
    /// identified
    /// by names that are unique to the account used to create them and the Amazon
    /// Web Services
    /// Region where they are created.
    backup_vault_name: []const u8,

    /// An Amazon Resource Name (ARN) that uniquely identifies a recovery point; for
    /// example,
    /// `arn:aws:backup:us-east-1:123456789012:recovery-point:1EB3B5E7-9EB0-435A-A80B-108B488B0D45`.
    recovery_point_arn: []const u8,

    pub const json_field_names = .{
        .backup_vault_account_id = "BackupVaultAccountId",
        .backup_vault_name = "BackupVaultName",
        .recovery_point_arn = "RecoveryPointArn",
    };
};

pub const DescribeRecoveryPointOutput = struct {
    /// The size, in bytes, of a backup.
    backup_size_in_bytes: ?i64 = null,

    /// An ARN that uniquely identifies a backup vault; for example,
    /// `arn:aws:backup:us-east-1:123456789012:backup-vault:aBackupVault`.
    backup_vault_arn: ?[]const u8 = null,

    /// The name of a logical container where backups are stored. Backup vaults are
    /// identified
    /// by names that are unique to the account used to create them and the Region
    /// where they are
    /// created.
    backup_vault_name: ?[]const u8 = null,

    /// A `CalculatedLifecycle` object containing `DeleteAt` and
    /// `MoveToColdStorageAt` timestamps.
    calculated_lifecycle: ?CalculatedLifecycle = null,

    /// The date and time that a job to create a recovery point is completed, in
    /// Unix format and
    /// Coordinated Universal Time (UTC). The value of `CompletionDate` is accurate
    /// to
    /// milliseconds. For example, the value 1516925490.087 represents Friday,
    /// January 26, 2018
    /// 12:11:30.087 AM.
    completion_date: ?i64 = null,

    /// The identifier of a resource within a composite group, such as
    /// nested (child) recovery point belonging to a composite (parent) stack. The
    /// ID is transferred from the [
    /// logical
    /// ID](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/resources-section-structure.html#resources-section-structure-syntax) within a stack.
    composite_member_identifier: ?[]const u8 = null,

    /// Contains identifying information about the creation of a recovery point,
    /// including the
    /// `BackupPlanArn`, `BackupPlanId`, `BackupPlanVersion`,
    /// and `BackupRuleId` of the backup plan used to create it.
    created_by: ?RecoveryPointCreator = null,

    /// The date and time that a recovery point is created, in Unix format and
    /// Coordinated
    /// Universal Time (UTC). The value of `CreationDate` is accurate to
    /// milliseconds.
    /// For example, the value 1516925490.087 represents Friday, January 26, 2018
    /// 12:11:30.087
    /// AM.
    creation_date: ?i64 = null,

    /// The server-side encryption key used to protect your backups; for example,
    /// `arn:aws:kms:us-west-2:111122223333:key/1234abcd-12ab-34cd-56ef-1234567890ab`.
    encryption_key_arn: ?[]const u8 = null,

    /// The type of encryption key used for the recovery point. Valid values are
    /// CUSTOMER_MANAGED_KMS_KEY for customer-managed keys or Amazon Web
    /// Services_OWNED_KMS_KEY for Amazon Web Services-owned keys.
    encryption_key_type: ?EncryptionKeyType = null,

    /// Specifies the IAM role ARN used to create the target recovery point; for
    /// example,
    /// `arn:aws:iam::123456789012:role/S3Access`.
    iam_role_arn: ?[]const u8 = null,

    /// This is the current status for the backup index associated with the
    /// specified recovery
    /// point.
    ///
    /// Statuses are: `PENDING` | `ACTIVE` | `FAILED` |
    /// `DELETING`
    ///
    /// A recovery point with an index that has the status of `ACTIVE` can be
    /// included in a search.
    index_status: ?IndexStatus = null,

    /// A string in the form of a detailed message explaining the status of a backup
    /// index
    /// associated with the recovery point.
    index_status_message: ?[]const u8 = null,

    /// The date and time when the backup job that created this recovery point was
    /// initiated, in
    /// Unix format and Coordinated Universal Time (UTC).
    initiation_date: ?i64 = null,

    /// A Boolean value that is returned as `TRUE` if the specified recovery point
    /// is
    /// encrypted, or `FALSE` if the recovery point is not encrypted.
    is_encrypted: ?bool = null,

    /// This returns the boolean value that a recovery point is a parent (composite)
    /// job.
    is_parent: ?bool = null,

    /// The date and time that a recovery point was last restored, in Unix format
    /// and
    /// Coordinated Universal Time (UTC). The value of `LastRestoreTime` is accurate
    /// to
    /// milliseconds. For example, the value 1516925490.087 represents Friday,
    /// January 26, 2018
    /// 12:11:30.087 AM.
    last_restore_time: ?i64 = null,

    /// The lifecycle defines when a protected resource is transitioned to cold
    /// storage and when
    /// it expires. Backup transitions and expires backups automatically according
    /// to
    /// the lifecycle that you define.
    ///
    /// Backups that are transitioned to cold storage must be stored in cold storage
    /// for a
    /// minimum of 90 days. Therefore, the “retention” setting must be 90 days
    /// greater than the
    /// “transition to cold after days” setting. The “transition to cold after days”
    /// setting cannot
    /// be changed after a backup has been transitioned to cold.
    ///
    /// Resource types that can transition to cold storage are listed in the
    /// [Feature
    /// availability by
    /// resource](https://docs.aws.amazon.com/aws-backup/latest/devguide/backup-feature-availability.html#features-by-resource) table. Backup ignores this expression for other resource types.
    lifecycle: ?Lifecycle = null,

    /// This is an ARN that uniquely identifies a parent (composite) recovery point;
    /// for example,
    /// `arn:aws:backup:us-east-1:123456789012:recovery-point:1EB3B5E7-9EB0-435A-A80B-108B488B0D45`.
    parent_recovery_point_arn: ?[]const u8 = null,

    /// An ARN that uniquely identifies a recovery point; for example,
    /// `arn:aws:backup:us-east-1:123456789012:recovery-point:1EB3B5E7-9EB0-435A-A80B-108B488B0D45`.
    recovery_point_arn: ?[]const u8 = null,

    /// An ARN that uniquely identifies a saved resource. The format of the ARN
    /// depends on the
    /// resource type.
    resource_arn: ?[]const u8 = null,

    /// The name of the resource that belongs to the specified backup.
    resource_name: ?[]const u8 = null,

    /// The type of Amazon Web Services resource to save as a recovery point; for
    /// example, an
    /// Amazon Elastic Block Store (Amazon EBS) volume or an Amazon Relational
    /// Database Service (Amazon RDS) database.
    resource_type: ?[]const u8 = null,

    /// Contains the latest scanning results against the recovery point and
    /// currently include `MalwareScanner`, `ScanJobState`, `Findings`, and
    /// `LastScanTimestamp`
    scan_results: ?[]const ScanResult = null,

    /// An Amazon Resource Name (ARN) that uniquely identifies the source vault
    /// where the
    /// resource was originally backed up in; for example,
    /// `arn:aws:backup:us-east-1:123456789012:backup-vault:aBackupVault`. If the
    /// recovery is
    /// restored to the same Amazon Web Services account or Region, this value will
    /// be
    /// `null`.
    source_backup_vault_arn: ?[]const u8 = null,

    /// A status code specifying the state of the recovery point. For more
    /// information, see
    /// [
    /// Recovery point
    /// status](https://docs.aws.amazon.com/aws-backup/latest/devguide/applicationstackbackups.html#cfnrecoverypointstatus) in the *Backup Developer
    /// Guide*.
    ///
    /// * `CREATING` status indicates that an Backup job has been
    /// initiated for a resource. The backup process has started and is actively
    /// processing
    /// a backup job for the associated recovery point.
    ///
    /// * `AVAILABLE` status indicates that the backup was successfully created
    /// for the recovery point. The backup process has completed without any issues,
    /// and the
    /// recovery point is now ready for use.
    ///
    /// * `PARTIAL` status indicates a composite recovery point has one or more
    /// nested recovery points that were not in the backup.
    ///
    /// * `EXPIRED` status indicates that the recovery point has exceeded its
    ///   retention
    /// period, but Backup lacks permission or is otherwise unable to delete it. To
    /// manually delete these recovery points, see [ Step 3:
    /// Delete the recovery
    /// points](https://docs.aws.amazon.com/aws-backup/latest/devguide/gs-cleanup-resources.html#cleanup-backups) in the *Clean up resources*
    /// section of *Getting started*.
    ///
    /// * `STOPPED` status occurs on a continuous backup where a user has taken some
    /// action that causes the continuous backup to be disabled. This can be caused
    /// by the removal
    /// of permissions, turning off versioning, turning off events being sent to
    /// EventBridge,
    /// or disabling the EventBridge rules that are put in place by Backup. For
    /// recovery points of Amazon S3, Amazon RDS, and Amazon Aurora
    /// resources, this status occurs when the retention period of a continuous
    /// backup rule is
    /// changed.
    ///
    /// To resolve `STOPPED` status, ensure that all requested permissions are in
    /// place and that versioning is enabled on the S3 bucket. Once these conditions
    /// are met, the
    /// next instance of a backup rule running will result in a new continuous
    /// recovery point being
    /// created. The recovery points with STOPPED status do not need to be deleted.
    ///
    /// For SAP HANA on Amazon EC2
    /// `STOPPED` status occurs due to user action, application misconfiguration, or
    /// backup failure. To ensure that future continuous backups succeed, refer to
    /// the recovery
    /// point status and check SAP HANA for details.
    status: ?RecoveryPointStatus = null,

    /// A status message explaining the status of the recovery point.
    status_message: ?[]const u8 = null,

    /// Specifies the storage class of the recovery point. Valid values are `WARM`
    /// or
    /// `COLD`.
    storage_class: ?StorageClass = null,

    /// The type of vault in which the described recovery point is stored.
    vault_type: ?VaultType = null,

    pub const json_field_names = .{
        .backup_size_in_bytes = "BackupSizeInBytes",
        .backup_vault_arn = "BackupVaultArn",
        .backup_vault_name = "BackupVaultName",
        .calculated_lifecycle = "CalculatedLifecycle",
        .completion_date = "CompletionDate",
        .composite_member_identifier = "CompositeMemberIdentifier",
        .created_by = "CreatedBy",
        .creation_date = "CreationDate",
        .encryption_key_arn = "EncryptionKeyArn",
        .encryption_key_type = "EncryptionKeyType",
        .iam_role_arn = "IamRoleArn",
        .index_status = "IndexStatus",
        .index_status_message = "IndexStatusMessage",
        .initiation_date = "InitiationDate",
        .is_encrypted = "IsEncrypted",
        .is_parent = "IsParent",
        .last_restore_time = "LastRestoreTime",
        .lifecycle = "Lifecycle",
        .parent_recovery_point_arn = "ParentRecoveryPointArn",
        .recovery_point_arn = "RecoveryPointArn",
        .resource_arn = "ResourceArn",
        .resource_name = "ResourceName",
        .resource_type = "ResourceType",
        .scan_results = "ScanResults",
        .source_backup_vault_arn = "SourceBackupVaultArn",
        .status = "Status",
        .status_message = "StatusMessage",
        .storage_class = "StorageClass",
        .vault_type = "VaultType",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeRecoveryPointInput, options: CallOptions) !DescribeRecoveryPointOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeRecoveryPointInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("backup", "Backup", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var path_buf: std.ArrayList(u8) = .{};
    try path_buf.appendSlice(allocator, "/backup-vaults/");
    try path_buf.appendSlice(allocator, input.backup_vault_name);
    try path_buf.appendSlice(allocator, "/recovery-points/");
    try path_buf.appendSlice(allocator, input.recovery_point_arn);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeRecoveryPointOutput {
    var result: DescribeRecoveryPointOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(DescribeRecoveryPointOutput, body, allocator);
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
