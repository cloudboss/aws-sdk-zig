const IndexStatus = @import("index_status.zig").IndexStatus;

/// This is a recovery point that has an associated backup index.
///
/// Only recovery points with a backup index can be
/// included in a search.
pub const IndexedRecoveryPoint = struct {
    /// The date and time that a backup was created, in Unix format and Coordinated
    /// Universal Time (UTC). The value of `CreationDate` is accurate to
    /// milliseconds.
    /// For example, the value 1516925490.087 represents Friday, January 26, 2018
    /// 12:11:30.087
    /// AM.
    backup_creation_date: ?i64 = null,

    /// An ARN that uniquely identifies the backup vault where the recovery
    /// point index is stored.
    ///
    /// For example,
    /// `arn:aws:backup:us-east-1:123456789012:backup-vault:aBackupVault`.
    backup_vault_arn: ?[]const u8 = null,

    /// This specifies the IAM role ARN used for this operation.
    ///
    /// For example, arn:aws:iam::123456789012:role/S3Access
    iam_role_arn: ?[]const u8 = null,

    /// The date and time that a backup index was created, in Unix format and
    /// Coordinated
    /// Universal Time (UTC). The value of `CreationDate` is accurate to
    /// milliseconds.
    /// For example, the value 1516925490.087 represents Friday, January 26, 2018
    /// 12:11:30.087
    /// AM.
    index_creation_date: ?i64 = null,

    /// This is the current status for the backup index associated
    /// with the specified recovery point.
    ///
    /// Statuses are: `PENDING` | `ACTIVE` | `FAILED` | `DELETING`
    ///
    /// A recovery point with an index that has the status of `ACTIVE`
    /// can be included in a search.
    index_status: ?IndexStatus = null,

    /// A string in the form of a detailed message explaining the status of a backup
    /// index associated
    /// with the recovery point.
    index_status_message: ?[]const u8 = null,

    /// An ARN that uniquely identifies a recovery point; for example,
    /// `arn:aws:backup:us-east-1:123456789012:recovery-point:1EB3B5E7-9EB0-435A-A80B-108B488B0D45`
    recovery_point_arn: ?[]const u8 = null,

    /// The resource type of the indexed recovery point.
    ///
    /// * `EBS` for Amazon Elastic Block Store
    ///
    /// * `S3` for Amazon Simple Storage Service (Amazon S3)
    resource_type: ?[]const u8 = null,

    /// A string of the Amazon Resource Name (ARN) that uniquely identifies
    /// the source resource.
    source_resource_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .backup_creation_date = "BackupCreationDate",
        .backup_vault_arn = "BackupVaultArn",
        .iam_role_arn = "IamRoleArn",
        .index_creation_date = "IndexCreationDate",
        .index_status = "IndexStatus",
        .index_status_message = "IndexStatusMessage",
        .recovery_point_arn = "RecoveryPointArn",
        .resource_type = "ResourceType",
        .source_resource_arn = "SourceResourceArn",
    };
};
