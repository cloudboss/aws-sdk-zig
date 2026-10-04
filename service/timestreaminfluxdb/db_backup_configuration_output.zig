const AutomatedDbBackupType = @import("automated_db_backup_type.zig").AutomatedDbBackupType;

/// Contains the configuration and status for an automated backup schedule.
pub const DbBackupConfigurationOutput = struct {
    /// The custom cron schedule expression for the backup, if applicable.
    custom_schedule: ?[]const u8 = null,

    /// Indicates whether this backup configuration is enabled.
    enabled: bool,

    /// The next scheduled time for an automated backup to be taken.
    next_automated_backup_time: ?i64 = null,

    /// The number of days automated backups are retained.
    retention_days: i32,

    /// The type of automated backup schedule.
    @"type": AutomatedDbBackupType,

    pub const json_field_names = .{
        .custom_schedule = "customSchedule",
        .enabled = "enabled",
        .next_automated_backup_time = "nextAutomatedBackupTime",
        .retention_days = "retentionDays",
        .@"type" = "type",
    };
};
