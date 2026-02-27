const AggregatedScanResult = @import("aggregated_scan_result.zig").AggregatedScanResult;
const CalculatedLifecycle = @import("calculated_lifecycle.zig").CalculatedLifecycle;
const RecoveryPointCreator = @import("recovery_point_creator.zig").RecoveryPointCreator;
const EncryptionKeyType = @import("encryption_key_type.zig").EncryptionKeyType;
const IndexStatus = @import("index_status.zig").IndexStatus;
const Lifecycle = @import("lifecycle.zig").Lifecycle;
const RecoveryPointStatus = @import("recovery_point_status.zig").RecoveryPointStatus;
const VaultType = @import("vault_type.zig").VaultType;

/// Contains detailed information about the recovery points stored in a backup
/// vault.
pub const RecoveryPointByBackupVault = struct {
    /// Contains the latest scanning results against the recovery point and
    /// currently include
    /// `FailedScan`, `Findings`, `LastComputed`.
    aggregated_scan_result: ?AggregatedScanResult,

    /// The size, in bytes, of a backup.
    backup_size_in_bytes: ?i64,

    /// An ARN that uniquely identifies a backup vault; for example,
    /// `arn:aws:backup:us-east-1:123456789012:backup-vault:aBackupVault`.
    backup_vault_arn: ?[]const u8,

    /// The name of a logical container where backups are stored. Backup vaults are
    /// identified
    /// by names that are unique to the account used to create them and the Amazon
    /// Web Services
    /// Region where they are created.
    backup_vault_name: ?[]const u8,

    /// A `CalculatedLifecycle` object containing `DeleteAt` and
    /// `MoveToColdStorageAt` timestamps.
    calculated_lifecycle: ?CalculatedLifecycle,

    /// The date and time a job to restore a recovery point is completed, in Unix
    /// format and
    /// Coordinated Universal Time (UTC). The value of `CompletionDate` is accurate
    /// to
    /// milliseconds. For example, the value 1516925490.087 represents Friday,
    /// January 26, 2018
    /// 12:11:30.087 AM.
    completion_date: ?i64,

    /// The identifier of a resource within a composite group, such as
    /// nested (child) recovery point belonging to a composite (parent) stack. The
    /// ID is transferred from
    /// the [
    /// logical
    /// ID](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/resources-section-structure.html#resources-section-structure-syntax) within a stack.
    composite_member_identifier: ?[]const u8,

    /// Contains identifying information about the creation of a recovery point,
    /// including the
    /// `BackupPlanArn`, `BackupPlanId`, `BackupPlanVersion`,
    /// and `BackupRuleId` of the backup plan that is used to create it.
    created_by: ?RecoveryPointCreator,

    /// The date and time a recovery point is created, in Unix format and
    /// Coordinated Universal
    /// Time (UTC). The value of `CreationDate` is accurate to milliseconds. For
    /// example, the value 1516925490.087 represents Friday, January 26, 2018
    /// 12:11:30.087
    /// AM.
    creation_date: ?i64,

    /// The server-side encryption key that is used to protect your backups; for
    /// example,
    /// `arn:aws:kms:us-west-2:111122223333:key/1234abcd-12ab-34cd-56ef-1234567890ab`.
    encryption_key_arn: ?[]const u8,

    /// The type of encryption key used for the recovery point. Valid values are
    /// CUSTOMER_MANAGED_KMS_KEY for customer-managed keys or Amazon Web
    /// Services_OWNED_KMS_KEY for Amazon Web Services-owned keys.
    encryption_key_type: ?EncryptionKeyType,

    /// Specifies the IAM role ARN used to create the target recovery point; for
    /// example,
    /// `arn:aws:iam::123456789012:role/S3Access`.
    iam_role_arn: ?[]const u8,

    /// This is the current status for the backup index associated
    /// with the specified recovery point.
    ///
    /// Statuses are: `PENDING` | `ACTIVE` | `FAILED` |
    /// `DELETING`
    ///
    /// A recovery point with an index that has the status of `ACTIVE`
    /// can be included in a search.
    index_status: ?IndexStatus,

    /// A string in the form of a detailed message explaining the status of a backup
    /// index associated
    /// with the recovery point.
    index_status_message: ?[]const u8,

    /// The date and time when the backup job that created this recovery point was
    /// initiated, in
    /// Unix format and Coordinated Universal Time (UTC).
    initiation_date: ?i64,

    /// A Boolean value that is returned as `TRUE` if the specified recovery point
    /// is
    /// encrypted, or `FALSE` if the recovery point is not encrypted.
    is_encrypted: bool = false,

    /// This is a boolean value indicating this is
    /// a parent (composite) recovery point.
    is_parent: bool = false,

    /// The date and time a recovery point was last restored, in Unix format and
    /// Coordinated
    /// Universal Time (UTC). The value of `LastRestoreTime` is accurate to
    /// milliseconds. For example, the value 1516925490.087 represents Friday,
    /// January 26, 2018
    /// 12:11:30.087 AM.
    last_restore_time: ?i64,

    /// The lifecycle defines when a protected resource is transitioned to cold
    /// storage and when
    /// it expires. Backup transitions and expires backups automatically according
    /// to
    /// the lifecycle that you define.
    ///
    /// Backups transitioned to cold storage must be stored in cold storage for a
    /// minimum of 90
    /// days. Therefore, the “retention” setting must be 90 days greater than the
    /// “transition to
    /// cold after days” setting. The “transition to cold after days” setting cannot
    /// be changed
    /// after a backup has been transitioned to cold.
    ///
    /// Resource types that can transition to cold storage are listed in the
    /// [Feature
    /// availability by
    /// resource](https://docs.aws.amazon.com/aws-backup/latest/devguide/backup-feature-availability.html#features-by-resource) table. Backup ignores this expression for
    /// other resource types.
    lifecycle: ?Lifecycle,

    /// The Amazon Resource Name (ARN) of the parent (composite)
    /// recovery point.
    parent_recovery_point_arn: ?[]const u8,

    /// An Amazon Resource Name (ARN) that uniquely identifies a recovery point; for
    /// example,
    /// `arn:aws:backup:us-east-1:123456789012:recovery-point:1EB3B5E7-9EB0-435A-A80B-108B488B0D45`.
    recovery_point_arn: ?[]const u8,

    /// An ARN that uniquely identifies a resource. The format of the ARN depends on
    /// the
    /// resource type.
    resource_arn: ?[]const u8,

    /// The non-unique name of the resource that
    /// belongs to the specified backup.
    resource_name: ?[]const u8,

    /// The type of Amazon Web Services resource saved as a recovery point; for
    /// example, an
    /// Amazon Elastic Block Store (Amazon EBS) volume or an Amazon Relational
    /// Database Service (Amazon RDS) database. For Windows Volume Shadow Copy
    /// Service (VSS) backups, the only
    /// supported resource type is Amazon EC2.
    resource_type: ?[]const u8,

    /// The backup vault where the recovery point was originally copied from. If the
    /// recovery
    /// point is restored to the same account this value will be `null`.
    source_backup_vault_arn: ?[]const u8,

    /// A status code specifying the state of the recovery point.
    status: ?RecoveryPointStatus,

    /// A message explaining the current status of the recovery point.
    status_message: ?[]const u8,

    /// The type of vault in which the described recovery point is stored.
    vault_type: ?VaultType,

    pub const json_field_names = .{
        .aggregated_scan_result = "AggregatedScanResult",
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
        .source_backup_vault_arn = "SourceBackupVaultArn",
        .status = "Status",
        .status_message = "StatusMessage",
        .vault_type = "VaultType",
    };
};
