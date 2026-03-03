const aws = @import("aws");

const RecoveryPointCreator = @import("recovery_point_creator.zig").RecoveryPointCreator;
const Lifecycle = @import("lifecycle.zig").Lifecycle;
const BackupJobState = @import("backup_job_state.zig").BackupJobState;

/// Contains detailed information about a backup job.
pub const BackupJob = struct {
    /// The account ID that owns the backup job.
    account_id: ?[]const u8 = null,

    /// Uniquely identifies a request to Backup to back up a resource.
    backup_job_id: ?[]const u8 = null,

    /// Specifies the backup option for a selected resource. This option is only
    /// available for
    /// Windows Volume Shadow Copy Service (VSS) backup jobs.
    ///
    /// Valid values: Set to `"WindowsVSS":"enabled"` to enable the
    /// `WindowsVSS` backup option and create a Windows VSS backup. Set to
    /// `"WindowsVSS":"disabled"` to create a regular backup. If you specify an
    /// invalid option, you get an `InvalidParameterValueException` exception.
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
    /// * Amazon FSx does not populate this value from the operation
    /// `GetBackupJobStatus` for FSx file systems.
    ///
    /// * An Amazon RDS instance will show as `0`.
    ///
    /// * For virtual machines running VMware, this value is passed to Backup
    /// through an asynchronous workflow, which can mean this displayed value can
    /// under-represent the actual backup size.
    backup_size_in_bytes: ?i64 = null,

    /// Represents the type of backup for a backup job.
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

    /// The date and time a job to create a backup job is completed, in Unix format
    /// and
    /// Coordinated Universal Time (UTC). The value of `CompletionDate` is accurate
    /// to
    /// milliseconds. For example, the value 1516925490.087 represents Friday,
    /// January 26, 2018
    /// 12:11:30.087 AM.
    completion_date: ?i64 = null,

    /// Contains identifying information about the creation of a backup job,
    /// including the
    /// `BackupPlanArn`, `BackupPlanId`, `BackupPlanVersion`,
    /// and `BackupRuleId` of the backup plan used to create it.
    created_by: ?RecoveryPointCreator = null,

    /// The date and time a backup job is created, in Unix format and Coordinated
    /// Universal Time
    /// (UTC). The value of `CreationDate` is accurate to milliseconds. For example,
    /// the
    /// value 1516925490.087 represents Friday, January 26, 2018 12:11:30.087 AM.
    creation_date: ?i64 = null,

    /// The Amazon Resource Name (ARN) of the KMS key used to encrypt the backup.
    /// This can be a customer-managed key or an Amazon Web Services managed key,
    /// depending on the vault configuration.
    encryption_key_arn: ?[]const u8 = null,

    /// The date and time a job to back up resources is expected to be completed, in
    /// Unix format
    /// and Coordinated Universal Time (UTC). The value of `ExpectedCompletionDate`
    /// is
    /// accurate to milliseconds. For example, the value 1516925490.087 represents
    /// Friday, January
    /// 26, 2018 12:11:30.087 AM.
    expected_completion_date: ?i64 = null,

    /// Specifies the IAM role ARN used to create the target recovery point. IAM
    /// roles other
    /// than the default role must include either `AWSBackup` or `AwsBackup`
    /// in the role name. For example,
    /// `arn:aws:iam::123456789012:role/AWSBackupRDSAccess`. Role names without
    /// those
    /// strings lack permissions to perform backup jobs.
    iam_role_arn: ?[]const u8 = null,

    /// The date on which the backup
    /// job was initiated.
    initiation_date: ?i64 = null,

    /// A boolean value indicating whether the backup is encrypted. All backups in
    /// Backup are encrypted, but this field indicates the encryption status for
    /// transparency.
    is_encrypted: bool = false,

    /// This is a boolean value indicating this is
    /// a parent (composite) backup job.
    is_parent: bool = false,

    /// This parameter is the job count for the specified
    /// message category.
    ///
    /// Example strings may include `AccessDenied`,
    /// `SUCCESS`, `AGGREGATE_ALL`, and
    /// `INVALIDPARAMETERS`. See
    /// [Monitoring](https://docs.aws.amazon.com/aws-backup/latest/devguide/monitoring.html)
    /// for a list of MessageCategory strings.
    ///
    /// The the value ANY returns count of all message categories.
    ///
    /// `AGGREGATE_ALL` aggregates job counts
    /// for all message categories and returns the sum.
    message_category: ?[]const u8 = null,

    /// This uniquely identifies a request to Backup
    /// to back up a resource. The return will be the
    /// parent (composite) job ID.
    parent_job_id: ?[]const u8 = null,

    /// Contains an estimated percentage complete of a job at the time the job
    /// status was
    /// queried.
    percent_done: ?[]const u8 = null,

    /// An ARN that uniquely identifies a recovery point; for example,
    /// `arn:aws:backup:us-east-1:123456789012:recovery-point:1EB3B5E7-9EB0-435A-A80B-108B488B0D45`.
    recovery_point_arn: ?[]const u8 = null,

    recovery_point_lifecycle: ?Lifecycle = null,

    /// An ARN that uniquely identifies a resource. The format of the ARN depends on
    /// the
    /// resource type.
    resource_arn: ?[]const u8 = null,

    /// The non-unique name of the resource that
    /// belongs to the specified backup.
    resource_name: ?[]const u8 = null,

    /// The type of Amazon Web Services resource to be backed up; for example, an
    /// Amazon Elastic Block Store (Amazon EBS) volume or an Amazon Relational
    /// Database Service (Amazon RDS) database. For Windows Volume Shadow Copy
    /// Service (VSS) backups, the only
    /// supported resource type is Amazon EC2.
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
