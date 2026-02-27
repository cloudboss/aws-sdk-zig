const aws = @import("aws");

const RecoveryPointCreator = @import("recovery_point_creator.zig").RecoveryPointCreator;
const Lifecycle = @import("lifecycle.zig").Lifecycle;
const CopyJobState = @import("copy_job_state.zig").CopyJobState;

/// Contains detailed information about a copy job.
pub const CopyJob = struct {
    /// The account ID that owns the copy job.
    account_id: ?[]const u8,

    /// The size, in bytes, of a copy job.
    backup_size_in_bytes: ?i64,

    /// This returns the statistics of the included
    /// child (nested) copy jobs.
    child_jobs_in_state: ?[]const aws.map.MapEntry(i64),

    /// The date and time a copy job is completed, in Unix format and Coordinated
    /// Universal Time
    /// (UTC). The value of `CompletionDate` is accurate to milliseconds. For
    /// example,
    /// the value 1516925490.087 represents Friday, January 26, 2018 12:11:30.087
    /// AM.
    completion_date: ?i64,

    /// The identifier of a resource within a composite group, such as
    /// nested (child) recovery point belonging to a composite (parent) stack. The
    /// ID is transferred from
    /// the [
    /// logical
    /// ID](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/resources-section-structure.html#resources-section-structure-syntax) within a stack.
    composite_member_identifier: ?[]const u8,

    /// Uniquely identifies a copy job.
    copy_job_id: ?[]const u8,

    created_by: ?RecoveryPointCreator,

    /// The backup job ID that initiated this copy job. Only applicable to scheduled
    /// copy
    /// jobs and automatic copy jobs to logically air-gapped vault.
    created_by_backup_job_id: ?[]const u8,

    /// The date and time a copy job is created, in Unix format and Coordinated
    /// Universal Time
    /// (UTC). The value of `CreationDate` is accurate to milliseconds. For example,
    /// the
    /// value 1516925490.087 represents Friday, January 26, 2018 12:11:30.087 AM.
    creation_date: ?i64,

    /// An Amazon Resource Name (ARN) that uniquely identifies a destination copy
    /// vault; for
    /// example, `arn:aws:backup:us-east-1:123456789012:backup-vault:aBackupVault`.
    destination_backup_vault_arn: ?[]const u8,

    /// The Amazon Resource Name (ARN) of the KMS key used to encrypt the copied
    /// backup in the destination vault. This can be a customer-managed key or an
    /// Amazon Web Services managed key.
    destination_encryption_key_arn: ?[]const u8,

    /// An ARN that uniquely identifies a destination recovery point; for example,
    /// `arn:aws:backup:us-east-1:123456789012:recovery-point:1EB3B5E7-9EB0-435A-A80B-108B488B0D45`.
    destination_recovery_point_arn: ?[]const u8,

    destination_recovery_point_lifecycle: ?Lifecycle,

    /// The lock state of the destination backup vault. For logically air-gapped
    /// vaults, this indicates whether the vault is locked in compliance mode. Valid
    /// values include `LOCKED` and `UNLOCKED`.
    destination_vault_lock_state: ?[]const u8,

    /// The type of destination backup vault where the copied recovery point is
    /// stored. Valid values are `BACKUP_VAULT` for standard backup vaults and
    /// `LOGICALLY_AIR_GAPPED_BACKUP_VAULT` for logically air-gapped vaults.
    destination_vault_type: ?[]const u8,

    /// Specifies the IAM role ARN used to copy the target recovery point; for
    /// example,
    /// `arn:aws:iam::123456789012:role/S3Access`.
    iam_role_arn: ?[]const u8,

    /// This is a boolean value indicating this is
    /// a parent (composite) copy job.
    is_parent: bool = false,

    /// This parameter is the job count for the specified
    /// message category.
    ///
    /// Example strings may include `AccessDenied`,
    /// `SUCCESS`, `AGGREGATE_ALL`, and
    /// `InvalidParameters`. See
    /// [Monitoring](https://docs.aws.amazon.com/aws-backup/latest/devguide/monitoring.html)
    /// for a list of MessageCategory strings.
    ///
    /// The the value ANY returns count of all message categories.
    ///
    /// `AGGREGATE_ALL` aggregates job counts
    /// for all message categories and returns the sum
    message_category: ?[]const u8,

    /// The number of child (nested) copy jobs.
    number_of_child_jobs: ?i64,

    /// This uniquely identifies a request to Backup
    /// to copy a resource. The return will be the
    /// parent (composite) job ID.
    parent_job_id: ?[]const u8,

    /// The Amazon Web Services resource to be copied; for example, an Amazon
    /// Elastic Block Store
    /// (Amazon EBS) volume or an Amazon Relational Database Service (Amazon RDS)
    /// database.
    resource_arn: ?[]const u8,

    /// The non-unique name of the resource that
    /// belongs to the specified backup.
    resource_name: ?[]const u8,

    /// The type of Amazon Web Services resource to be copied; for example, an
    /// Amazon Elastic Block Store (Amazon EBS) volume or an Amazon Relational
    /// Database Service (Amazon RDS) database.
    resource_type: ?[]const u8,

    /// An Amazon Resource Name (ARN) that uniquely identifies a source copy vault;
    /// for example,
    /// `arn:aws:backup:us-east-1:123456789012:backup-vault:aBackupVault`.
    source_backup_vault_arn: ?[]const u8,

    /// An ARN that uniquely identifies a source recovery point; for example,
    /// `arn:aws:backup:us-east-1:123456789012:recovery-point:1EB3B5E7-9EB0-435A-A80B-108B488B0D45`.
    source_recovery_point_arn: ?[]const u8,

    /// The current state of a copy job.
    state: ?CopyJobState,

    /// A detailed message explaining the status of the job to copy a resource.
    status_message: ?[]const u8,

    pub const json_field_names = .{
        .account_id = "AccountId",
        .backup_size_in_bytes = "BackupSizeInBytes",
        .child_jobs_in_state = "ChildJobsInState",
        .completion_date = "CompletionDate",
        .composite_member_identifier = "CompositeMemberIdentifier",
        .copy_job_id = "CopyJobId",
        .created_by = "CreatedBy",
        .created_by_backup_job_id = "CreatedByBackupJobId",
        .creation_date = "CreationDate",
        .destination_backup_vault_arn = "DestinationBackupVaultArn",
        .destination_encryption_key_arn = "DestinationEncryptionKeyArn",
        .destination_recovery_point_arn = "DestinationRecoveryPointArn",
        .destination_recovery_point_lifecycle = "DestinationRecoveryPointLifecycle",
        .destination_vault_lock_state = "DestinationVaultLockState",
        .destination_vault_type = "DestinationVaultType",
        .iam_role_arn = "IamRoleArn",
        .is_parent = "IsParent",
        .message_category = "MessageCategory",
        .number_of_child_jobs = "NumberOfChildJobs",
        .parent_job_id = "ParentJobId",
        .resource_arn = "ResourceArn",
        .resource_name = "ResourceName",
        .resource_type = "ResourceType",
        .source_backup_vault_arn = "SourceBackupVaultArn",
        .source_recovery_point_arn = "SourceRecoveryPointArn",
        .state = "State",
        .status_message = "StatusMessage",
    };
};
