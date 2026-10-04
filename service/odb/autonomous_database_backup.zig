const AutonomousDatabaseBackupStatus = @import("autonomous_database_backup_status.zig").AutonomousDatabaseBackupStatus;
const AutonomousDatabaseBackupType = @import("autonomous_database_backup_type.zig").AutonomousDatabaseBackupType;

/// Information about an Autonomous Database backup.
pub const AutonomousDatabaseBackup = struct {
    /// The Amazon Resource Name (ARN) of the Autonomous Database backup.
    autonomous_database_backup_arn: ?[]const u8 = null,

    /// The unique identifier of the Autonomous Database backup.
    autonomous_database_backup_id: ?[]const u8 = null,

    /// The unique identifier of the Autonomous Database that the backup was created
    /// from.
    autonomous_database_id: ?[]const u8 = null,

    /// The Oracle Database software version of the Autonomous Database backup.
    db_version: ?[]const u8 = null,

    /// The user-friendly name of the Autonomous Database backup.
    display_name: ?[]const u8 = null,

    /// Indicates whether the backup was created automatically.
    is_automatic: ?bool = null,

    /// The Oracle Cloud Identifier (OCID) of the Autonomous Database backup.
    ocid: ?[]const u8 = null,

    /// The retention period, in days, for the Autonomous Database backup.
    retention_period_in_days: ?i32 = null,

    /// The size of the Autonomous Database backup, in terabytes (TB).
    size_in_t_bs: ?f64 = null,

    /// The current status of the Autonomous Database backup.
    status: ?AutonomousDatabaseBackupStatus = null,

    /// Additional information about the current status of the Autonomous Database
    /// backup, if applicable.
    status_reason: ?[]const u8 = null,

    /// The date and time until which the Autonomous Database backup is available
    /// for restore.
    time_available_till: ?i64 = null,

    /// The date and time when the Autonomous Database backup ended.
    time_ended: ?i64 = null,

    /// The date and time when the Autonomous Database backup started.
    time_started: ?i64 = null,

    /// The type of the Autonomous Database backup.
    @"type": ?AutonomousDatabaseBackupType = null,

    pub const json_field_names = .{
        .autonomous_database_backup_arn = "autonomousDatabaseBackupArn",
        .autonomous_database_backup_id = "autonomousDatabaseBackupId",
        .autonomous_database_id = "autonomousDatabaseId",
        .db_version = "dbVersion",
        .display_name = "displayName",
        .is_automatic = "isAutomatic",
        .ocid = "ocid",
        .retention_period_in_days = "retentionPeriodInDays",
        .size_in_t_bs = "sizeInTBs",
        .status = "status",
        .status_reason = "statusReason",
        .time_available_till = "timeAvailableTill",
        .time_ended = "timeEnded",
        .time_started = "timeStarted",
        .@"type" = "type",
    };
};
