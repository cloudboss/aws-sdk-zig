const SnapshotStatus = @import("snapshot_status.zig").SnapshotStatus;

/// A snapshot object that contains databases.
pub const Snapshot = struct {
    /// All of the Amazon Web Services accounts that have access to restore a
    /// snapshot to a provisioned cluster.
    accounts_with_provisioned_restore_access: ?[]const []const u8 = null,

    /// All of the Amazon Web Services accounts that have access to restore a
    /// snapshot to a namespace.
    accounts_with_restore_access: ?[]const []const u8 = null,

    /// The size of the incremental backup in megabytes.
    actual_incremental_backup_size_in_mega_bytes: ?f64 = null,

    /// The Amazon Resource Name (ARN) for the namespace's admin user credentials
    /// secret.
    admin_password_secret_arn: ?[]const u8 = null,

    /// The ID of the Key Management Service (KMS) key used to encrypt and store the
    /// namespace's admin credentials secret.
    admin_password_secret_kms_key_id: ?[]const u8 = null,

    /// The username of the database within a snapshot.
    admin_username: ?[]const u8 = null,

    /// The size in megabytes of the data that has been backed up to a snapshot.
    backup_progress_in_mega_bytes: ?f64 = null,

    /// The rate at which data is backed up into a snapshot in megabytes per second.
    current_backup_rate_in_mega_bytes_per_second: ?f64 = null,

    /// The amount of time it took to back up data into a snapshot.
    elapsed_time_in_seconds: ?i64 = null,

    /// The estimated amount of seconds until the snapshot completes backup.
    estimated_seconds_to_completion: ?i64 = null,

    /// The unique identifier of the KMS key used to encrypt the snapshot.
    kms_key_id: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the namespace the snapshot was created
    /// from.
    namespace_arn: ?[]const u8 = null,

    /// The name of the namepsace.
    namespace_name: ?[]const u8 = null,

    /// The owner Amazon Web Services; account of the snapshot.
    owner_account: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the snapshot.
    snapshot_arn: ?[]const u8 = null,

    /// The timestamp of when the snapshot was created.
    snapshot_create_time: ?i64 = null,

    /// The name of the snapshot.
    snapshot_name: ?[]const u8 = null,

    /// The amount of days until the snapshot is deleted.
    snapshot_remaining_days: ?i32 = null,

    /// The period of time, in days, of how long the snapshot is retained.
    snapshot_retention_period: ?i32 = null,

    /// The timestamp of when data within the snapshot started getting retained.
    snapshot_retention_start_time: ?i64 = null,

    /// The status of the snapshot.
    status: ?SnapshotStatus = null,

    /// The total size, in megabytes, of how big the snapshot is.
    total_backup_size_in_mega_bytes: ?f64 = null,

    pub const json_field_names = .{
        .accounts_with_provisioned_restore_access = "accountsWithProvisionedRestoreAccess",
        .accounts_with_restore_access = "accountsWithRestoreAccess",
        .actual_incremental_backup_size_in_mega_bytes = "actualIncrementalBackupSizeInMegaBytes",
        .admin_password_secret_arn = "adminPasswordSecretArn",
        .admin_password_secret_kms_key_id = "adminPasswordSecretKmsKeyId",
        .admin_username = "adminUsername",
        .backup_progress_in_mega_bytes = "backupProgressInMegaBytes",
        .current_backup_rate_in_mega_bytes_per_second = "currentBackupRateInMegaBytesPerSecond",
        .elapsed_time_in_seconds = "elapsedTimeInSeconds",
        .estimated_seconds_to_completion = "estimatedSecondsToCompletion",
        .kms_key_id = "kmsKeyId",
        .namespace_arn = "namespaceArn",
        .namespace_name = "namespaceName",
        .owner_account = "ownerAccount",
        .snapshot_arn = "snapshotArn",
        .snapshot_create_time = "snapshotCreateTime",
        .snapshot_name = "snapshotName",
        .snapshot_remaining_days = "snapshotRemainingDays",
        .snapshot_retention_period = "snapshotRetentionPeriod",
        .snapshot_retention_start_time = "snapshotRetentionStartTime",
        .status = "status",
        .total_backup_size_in_mega_bytes = "totalBackupSizeInMegaBytes",
    };
};
