const AggregatedScanResult = @import("aggregated_scan_result.zig").AggregatedScanResult;
const EncryptionKeyType = @import("encryption_key_type.zig").EncryptionKeyType;
const IndexStatus = @import("index_status.zig").IndexStatus;
const RecoveryPointStatus = @import("recovery_point_status.zig").RecoveryPointStatus;
const VaultType = @import("vault_type.zig").VaultType;

/// Contains detailed information about a saved recovery point.
pub const RecoveryPointByResource = struct {
    /// Contains the latest scanning results against the recovery point and
    /// currently include
    /// `FailedScan`, `Findings`, `LastComputed`.
    aggregated_scan_result: ?AggregatedScanResult,

    /// The size, in bytes, of a backup.
    backup_size_bytes: ?i64,

    /// The name of a logical container where backups are stored. Backup vaults are
    /// identified
    /// by names that are unique to the account used to create them and the Amazon
    /// Web Services
    /// Region where they are created.
    backup_vault_name: ?[]const u8,

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

    /// This is the current status for the backup index associated
    /// with the specified recovery point.
    ///
    /// Statuses are: `PENDING` | `ACTIVE` | `FAILED` | `DELETING`
    ///
    /// A recovery point with an index that has the status of `ACTIVE`
    /// can be included in a search.
    index_status: ?IndexStatus,

    /// A string in the form of a detailed message explaining the status of a backup
    /// index
    /// associated with the recovery point.
    index_status_message: ?[]const u8,

    /// This is a boolean value indicating this is
    /// a parent (composite) recovery point.
    is_parent: bool = false,

    /// The Amazon Resource Name (ARN) of the parent (composite)
    /// recovery point.
    parent_recovery_point_arn: ?[]const u8,

    /// An Amazon Resource Name (ARN) that uniquely identifies a recovery point; for
    /// example,
    /// `arn:aws:backup:us-east-1:123456789012:recovery-point:1EB3B5E7-9EB0-435A-A80B-108B488B0D45`.
    recovery_point_arn: ?[]const u8,

    /// The non-unique name of the resource that
    /// belongs to the specified backup.
    resource_name: ?[]const u8,

    /// A status code specifying the state of the recovery point.
    status: ?RecoveryPointStatus,

    /// A message explaining the current status of the recovery point.
    status_message: ?[]const u8,

    /// The type of vault in which the described recovery point is
    /// stored.
    vault_type: ?VaultType,

    pub const json_field_names = .{
        .aggregated_scan_result = "AggregatedScanResult",
        .backup_size_bytes = "BackupSizeBytes",
        .backup_vault_name = "BackupVaultName",
        .creation_date = "CreationDate",
        .encryption_key_arn = "EncryptionKeyArn",
        .encryption_key_type = "EncryptionKeyType",
        .index_status = "IndexStatus",
        .index_status_message = "IndexStatusMessage",
        .is_parent = "IsParent",
        .parent_recovery_point_arn = "ParentRecoveryPointArn",
        .recovery_point_arn = "RecoveryPointArn",
        .resource_name = "ResourceName",
        .status = "Status",
        .status_message = "StatusMessage",
        .vault_type = "VaultType",
    };
};
