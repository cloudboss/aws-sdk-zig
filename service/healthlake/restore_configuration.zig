const ContinuousBackupRestoreConfiguration = @import("continuous_backup_restore_configuration.zig").ContinuousBackupRestoreConfiguration;

/// Specifies the type and parameters for the restore operation.
pub const RestoreConfiguration = union(enum) {
    /// Configuration for restoring from continuous backup to a specific point in
    /// time.
    continuous_backup_restore_configuration: ?ContinuousBackupRestoreConfiguration,

    pub const json_field_names = .{
        .continuous_backup_restore_configuration = "ContinuousBackupRestoreConfiguration",
    };
};
