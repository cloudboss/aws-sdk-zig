const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const RecoveryPointCreator = @import("recovery_point_creator.zig").RecoveryPointCreator;
const Lifecycle = @import("lifecycle.zig").Lifecycle;
const BackupJobState = @import("backup_job_state.zig").BackupJobState;

pub const DescribeBackupJobInput = struct {
    /// Uniquely identifies a request to Backup to back up a resource.
    backup_job_id: []const u8,

    pub const json_field_names = .{
        .backup_job_id = "BackupJobId",
    };
};

pub const DescribeBackupJobOutput = struct {
    /// Returns the account ID that owns the backup job.
    account_id: ?[]const u8 = null,

    /// Uniquely identifies a request to Backup to back up a resource.
    backup_job_id: ?[]const u8 = null,

    /// Represents the options specified as part of backup plan or on-demand backup
    /// job.
    backup_options: ?[]const aws.map.StringMapEntry = null,

    /// The size, in bytes, of a backup (recovery point).
    ///
    /// This value can render differently depending on the resource type as Backup
    /// pulls in data information from other Amazon Web Services services. For
    /// example, the
    /// value returned may show a value of `0`, which may differ from the
    /// anticipated value.
    ///
    /// The expected behavior for values by resource type are described as follows:
    ///
    /// * Amazon Aurora, Amazon DocumentDB, and Amazon Neptune do
    /// not have this value populate from the operation
    /// `GetBackupJobStatus`.
    ///
    /// * For Amazon DynamoDB with advanced features, this value refers to the size
    /// of the recovery point (backup).
    ///
    /// * Amazon EC2 and Amazon EBS show volume size (provisioned storage)
    /// returned as part of this value. Amazon EBS does not return backup size
    /// information; snapshot size will have the same value as the original resource
    /// that was
    /// backed up.
    ///
    /// * For Amazon EFS, this value refers to the delta bytes transferred during a
    /// backup.
    ///
    /// * For Amazon EKS, this value refers to the size of your nested EKS recovery
    ///   point.
    ///
    /// * Amazon FSx does not populate this value from the operation
    /// `GetBackupJobStatus` for FSx file systems.
    ///
    /// * An Amazon RDS instance will show as `0`.
    ///
    /// * For virtual machines running VMware, this value is passed to Backup
    /// through an asynchronous workflow, which can mean this displayed value can
    /// under-represent the actual backup size.
    backup_size_in_bytes: ?i64 = null,

    /// Represents the actual backup type selected for a backup job. For example, if
    /// a
    /// successful Windows Volume Shadow Copy Service (VSS) backup was taken,
    /// `BackupType` returns `"WindowsVSS"`. If `BackupType` is
    /// empty, then the backup type was a regular backup.
    backup_type: ?[]const u8 = null,

    /// An Amazon Resource Name (ARN) that uniquely identifies a backup vault; for
    /// example,
    /// `arn:aws:backup:us-east-1:123456789012:backup-vault:aBackupVault`.
    backup_vault_arn: ?[]const u8 = null,

    /// The name of a logical container where backups are stored. Backup vaults are
    /// identified
    /// by names that are unique to the account used to create them and the Amazon
    /// Web Services
    /// Region where they are created.
    backup_vault_name: ?[]const u8 = null,

    /// The size in bytes transferred to a backup vault at the time that the job
    /// status was
    /// queried.
    bytes_transferred: ?i64 = null,

    /// This returns the statistics of the included child (nested) backup jobs.
    child_jobs_in_state: ?[]const aws.map.MapEntry(i64) = null,

    /// The date and time that a job to create a backup job is completed, in Unix
    /// format and
    /// Coordinated Universal Time (UTC). The value of `CompletionDate` is accurate
    /// to
    /// milliseconds. For example, the value 1516925490.087 represents Friday,
    /// January 26, 2018
    /// 12:11:30.087 AM.
    completion_date: ?i64 = null,

    /// Contains identifying information about the creation of a backup job,
    /// including the
    /// `BackupPlanArn`, `BackupPlanId`, `BackupPlanVersion`,
    /// and `BackupRuleId` of the backup plan that is used to create it.
    created_by: ?RecoveryPointCreator = null,

    /// The date and time that a backup job is created, in Unix format and
    /// Coordinated Universal
    /// Time (UTC). The value of `CreationDate` is accurate to milliseconds. For
    /// example, the value 1516925490.087 represents Friday, January 26, 2018
    /// 12:11:30.087
    /// AM.
    creation_date: ?i64 = null,

    /// The Amazon Resource Name (ARN) of the KMS key used to encrypt the backup.
    /// This can be a customer-managed key or an Amazon Web Services managed key,
    /// depending on the vault configuration.
    encryption_key_arn: ?[]const u8 = null,

    /// The date and time that a job to back up resources is expected to be
    /// completed, in Unix
    /// format and Coordinated Universal Time (UTC). The value of
    /// `ExpectedCompletionDate` is accurate to milliseconds. For example, the value
    /// 1516925490.087 represents Friday, January 26, 2018 12:11:30.087 AM.
    expected_completion_date: ?i64 = null,

    /// Specifies the IAM role ARN used to create the target recovery point; for
    /// example,
    /// `arn:aws:iam::123456789012:role/S3Access`.
    iam_role_arn: ?[]const u8 = null,

    /// The date a backup job was initiated.
    initiation_date: ?i64 = null,

    /// A boolean value indicating whether the backup is encrypted. All backups in
    /// Backup are encrypted, but this field indicates the encryption status for
    /// transparency.
    is_encrypted: ?bool = null,

    /// This returns the boolean value that a backup job is a parent (composite)
    /// job.
    is_parent: ?bool = null,

    /// The job count for the specified
    /// message category.
    ///
    /// Example strings may include `AccessDenied`, `SUCCESS`,
    /// `AGGREGATE_ALL`, and `INVALIDPARAMETERS`. View
    /// [Monitoring](https://docs.aws.amazon.com/aws-backup/latest/devguide/monitoring.html)
    /// for a list of accepted MessageCategory strings.
    message_category: ?[]const u8 = null,

    /// This returns the number of child (nested) backup jobs.
    number_of_child_jobs: ?i64 = null,

    /// This returns the parent (composite) resource backup job ID.
    parent_job_id: ?[]const u8 = null,

    /// Contains an estimated percentage that is complete of a job at the time the
    /// job status
    /// was queried.
    percent_done: ?[]const u8 = null,

    /// An ARN that uniquely identifies a recovery point; for example,
    /// `arn:aws:backup:us-east-1:123456789012:recovery-point:1EB3B5E7-9EB0-435A-A80B-108B488B0D45`.
    recovery_point_arn: ?[]const u8 = null,

    recovery_point_lifecycle: ?Lifecycle = null,

    /// An ARN that uniquely identifies a saved resource. The format of the ARN
    /// depends on the
    /// resource type.
    resource_arn: ?[]const u8 = null,

    /// The non-unique name of the resource that
    /// belongs to the specified backup.
    resource_name: ?[]const u8 = null,

    /// The type of Amazon Web Services resource to be backed up; for example, an
    /// Amazon Elastic Block Store (Amazon EBS) volume or an Amazon Relational
    /// Database Service (Amazon RDS) database.
    resource_type: ?[]const u8 = null,

    /// Specifies the time in Unix format and Coordinated Universal Time (UTC) when
    /// a backup job
    /// must be started before it is canceled. The value is calculated by adding the
    /// start window
    /// to the scheduled time. So if the scheduled time were 6:00 PM and the start
    /// window is 2
    /// hours, the `StartBy` time would be 8:00 PM on the date specified. The value
    /// of
    /// `StartBy` is accurate to milliseconds. For example, the value 1516925490.087
    /// represents Friday, January 26, 2018 12:11:30.087 AM.
    start_by: ?i64 = null,

    /// The current state of a backup job.
    state: ?BackupJobState = null,

    /// A detailed message explaining the status of the job to back up a resource.
    status_message: ?[]const u8 = null,

    /// The lock state of the backup vault. For logically air-gapped vaults, this
    /// indicates whether the vault is locked in compliance mode. Valid values
    /// include `LOCKED` and `UNLOCKED`.
    vault_lock_state: ?[]const u8 = null,

    /// The type of backup vault where the recovery point is stored. Valid values
    /// are `BACKUP_VAULT` for standard backup vaults and
    /// `LOGICALLY_AIR_GAPPED_BACKUP_VAULT` for logically air-gapped vaults.
    vault_type: ?[]const u8 = null,

    pub const json_field_names = .{
        .account_id = "AccountId",
        .backup_job_id = "BackupJobId",
        .backup_options = "BackupOptions",
        .backup_size_in_bytes = "BackupSizeInBytes",
        .backup_type = "BackupType",
        .backup_vault_arn = "BackupVaultArn",
        .backup_vault_name = "BackupVaultName",
        .bytes_transferred = "BytesTransferred",
        .child_jobs_in_state = "ChildJobsInState",
        .completion_date = "CompletionDate",
        .created_by = "CreatedBy",
        .creation_date = "CreationDate",
        .encryption_key_arn = "EncryptionKeyArn",
        .expected_completion_date = "ExpectedCompletionDate",
        .iam_role_arn = "IamRoleArn",
        .initiation_date = "InitiationDate",
        .is_encrypted = "IsEncrypted",
        .is_parent = "IsParent",
        .message_category = "MessageCategory",
        .number_of_child_jobs = "NumberOfChildJobs",
        .parent_job_id = "ParentJobId",
        .percent_done = "PercentDone",
        .recovery_point_arn = "RecoveryPointArn",
        .recovery_point_lifecycle = "RecoveryPointLifecycle",
        .resource_arn = "ResourceArn",
        .resource_name = "ResourceName",
        .resource_type = "ResourceType",
        .start_by = "StartBy",
        .state = "State",
        .status_message = "StatusMessage",
        .vault_lock_state = "VaultLockState",
        .vault_type = "VaultType",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeBackupJobInput, options: CallOptions) !DescribeBackupJobOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeBackupJobInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("backup", "Backup", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var path_buf: std.ArrayList(u8) = .{};
    try path_buf.appendSlice(allocator, "/backup-jobs/");
    try path_buf.appendSlice(allocator, input.backup_job_id);
    const path = try path_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(host);
    request.method = .GET;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeBackupJobOutput {
    var result: DescribeBackupJobOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(DescribeBackupJobOutput, body, allocator);
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
