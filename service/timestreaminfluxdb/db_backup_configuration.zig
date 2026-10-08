const AutomatedDbBackupType = @import("automated_db_backup_type.zig").AutomatedDbBackupType;

/// Specifies the configuration for an automated backup schedule.
pub const DbBackupConfiguration = struct {
    /// A custom cron schedule expression for the backup. Required when type is
    /// CUSTOM_SCHEDULE.
    custom_schedule: ?[]const u8 = null,

    /// Specifies whether this backup configuration is enabled.
    enabled: bool,

    /// The number of days to retain automated backups. Valid values are 1 to 365.
    retention_days: i32,

    /// The type of automated backup schedule. Valid values are HOURLY, DAILY,
    /// WEEKLY, MONTHLY, CUSTOM_SCHEDULE, and CONTINUOUS.
    type: AutomatedDbBackupType,

    pub const json_field_names = .{
        .custom_schedule = "customSchedule",
        .enabled = "enabled",
        .retention_days = "retentionDays",
        .type = "type",
    };
};
