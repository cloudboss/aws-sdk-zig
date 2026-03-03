const AwsBackupRecoveryPointCalculatedLifecycleDetails = @import("aws_backup_recovery_point_calculated_lifecycle_details.zig").AwsBackupRecoveryPointCalculatedLifecycleDetails;
const AwsBackupRecoveryPointCreatedByDetails = @import("aws_backup_recovery_point_created_by_details.zig").AwsBackupRecoveryPointCreatedByDetails;
const AwsBackupRecoveryPointLifecycleDetails = @import("aws_backup_recovery_point_lifecycle_details.zig").AwsBackupRecoveryPointLifecycleDetails;

/// Contains detailed information about the recovery points stored in an Backup
/// backup vault.
/// A backup, or recovery point, represents the content of a resource at a
/// specified time.
pub const AwsBackupRecoveryPointDetails = struct {
    /// The size, in bytes, of a backup.
    backup_size_in_bytes: ?i64 = null,

    /// An Amazon Resource Name (ARN) that uniquely identifies a backup vault.
    backup_vault_arn: ?[]const u8 = null,

    /// The name of a logical container where backups are stored. Backup vaults are
    /// identified by names
    /// that are unique to the Amazon Web Services account used to create them and
    /// the Amazon Web Services Region
    /// where they are created. They consist of lowercase letters, numbers, and
    /// hyphens.
    backup_vault_name: ?[]const u8 = null,

    /// A `CalculatedLifecycle` object containing `DeleteAt` and
    /// `MoveToColdStorageAt` timestamps.
    calculated_lifecycle: ?AwsBackupRecoveryPointCalculatedLifecycleDetails = null,

    /// The date and time that a job to create a recovery point is completed, in
    /// Unix format and UTC.
    /// The value of `CompletionDate` is accurate to milliseconds. For example, the
    /// value 1516925490.087
    /// represents Friday, January 26, 2018 12:11:30.087 AM.
    completion_date: ?[]const u8 = null,

    /// Contains identifying information about the creation of a recovery point,
    /// including the
    /// `BackupPlanArn`, `BackupPlanId`, `BackupPlanVersion`, and `BackupRuleId`
    /// of the backup plan that is used to create it.
    created_by: ?AwsBackupRecoveryPointCreatedByDetails = null,

    /// The date and time a recovery point is created, in Unix format and UTC. The
    /// value of `CreationDate`
    /// is accurate to milliseconds. For example, the value 1516925490.087
    /// represents Friday, January 26, 2018 12:11:30.087 AM.
    creation_date: ?[]const u8 = null,

    /// The ARN for the server-side encryption key that is used to protect your
    /// backups.
    encryption_key_arn: ?[]const u8 = null,

    /// Specifies the IAM role ARN used to create the target recovery point
    iam_role_arn: ?[]const u8 = null,

    /// A Boolean value that is returned as `TRUE` if the specified recovery point
    /// is
    /// encrypted, or `FALSE` if the recovery point is not encrypted.
    is_encrypted: ?bool = null,

    /// The date and time that a recovery point was last restored, in Unix format
    /// and UTC. The value of
    /// `LastRestoreTime` is accurate to milliseconds. For example, the value
    /// 1516925490.087 represents
    /// Friday, January 26, 2018 12:11:30.087 AM.
    last_restore_time: ?[]const u8 = null,

    /// The lifecycle defines when a protected resource is transitioned to cold
    /// storage and when it
    /// expires. Backup transitions and expires backups automatically according to
    /// the lifecycle that
    /// you define
    lifecycle: ?AwsBackupRecoveryPointLifecycleDetails = null,

    /// An ARN that uniquely identifies a recovery point.
    recovery_point_arn: ?[]const u8 = null,

    /// An ARN that uniquely identifies a resource. The format of the ARN depends on
    /// the resource type.
    resource_arn: ?[]const u8 = null,

    /// The type of Amazon Web Services resource saved as a recovery point, such as
    /// an Amazon EBS volume or an Amazon RDS database.
    resource_type: ?[]const u8 = null,

    /// The ARN for the backup vault where the recovery point was originally copied
    /// from. If the recovery
    /// point is restored to the same account, this value will be null.
    source_backup_vault_arn: ?[]const u8 = null,

    /// A status code specifying the state of the recovery point. Valid values are
    /// as follows:
    ///
    /// * `COMPLETED`
    ///
    /// * `DELETING`
    ///
    /// * `EXPIRED`
    ///
    /// * `PARTIAL`
    status: ?[]const u8 = null,

    /// A message explaining the reason of the recovery point deletion failure.
    status_message: ?[]const u8 = null,

    /// Specifies the storage class of the recovery point. Valid values are as
    /// follows:
    ///
    /// * `COLD`
    ///
    /// * `DELETED`
    ///
    /// * `WARM`
    storage_class: ?[]const u8 = null,

    pub const json_field_names = .{
        .backup_size_in_bytes = "BackupSizeInBytes",
        .backup_vault_arn = "BackupVaultArn",
        .backup_vault_name = "BackupVaultName",
        .calculated_lifecycle = "CalculatedLifecycle",
        .completion_date = "CompletionDate",
        .created_by = "CreatedBy",
        .creation_date = "CreationDate",
        .encryption_key_arn = "EncryptionKeyArn",
        .iam_role_arn = "IamRoleArn",
        .is_encrypted = "IsEncrypted",
        .last_restore_time = "LastRestoreTime",
        .lifecycle = "Lifecycle",
        .recovery_point_arn = "RecoveryPointArn",
        .resource_arn = "ResourceArn",
        .resource_type = "ResourceType",
        .source_backup_vault_arn = "SourceBackupVaultArn",
        .status = "Status",
        .status_message = "StatusMessage",
        .storage_class = "StorageClass",
    };
};
