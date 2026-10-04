const BackupType = @import("backup_type.zig").BackupType;
const BackupStatus = @import("backup_status.zig").BackupStatus;

/// The backup configuration for the data store.
pub const BackupConfiguration = struct {
    /// Specifies whether tags are included in backups.
    backup_tags_enabled: bool = false,

    /// The type of backup.
    backup_type: ?BackupType = null,

    /// The number of days backup data is retained.
    retention_period_in_days: ?i32 = null,

    /// The backup status of the data store.
    status: ?BackupStatus = null,

    pub const json_field_names = .{
        .backup_tags_enabled = "BackupTagsEnabled",
        .backup_type = "BackupType",
        .retention_period_in_days = "RetentionPeriodInDays",
        .status = "Status",
    };
};
