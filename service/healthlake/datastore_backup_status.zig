const BackupConfiguration = @import("backup_configuration.zig").BackupConfiguration;

/// The backup status information for the data store.
pub const DatastoreBackupStatus = struct {
    /// The time backup was enabled on the data store.
    backup_enabled_at: ?i64 = null,

    /// The backup configuration for the data store.
    configuration: ?BackupConfiguration = null,

    /// The earliest point in time the data store can be restored to.
    earliest_restore_point: ?i64 = null,

    /// The latest point in time the data store can be restored to.
    latest_restore_point: ?i64 = null,

    /// The time the retained backup data is scheduled for permanent deletion.
    scheduled_permanent_deletion_time: ?i64 = null,

    pub const json_field_names = .{
        .backup_enabled_at = "BackupEnabledAt",
        .configuration = "Configuration",
        .earliest_restore_point = "EarliestRestorePoint",
        .latest_restore_point = "LatestRestorePoint",
        .scheduled_permanent_deletion_time = "ScheduledPermanentDeletionTime",
    };
};
