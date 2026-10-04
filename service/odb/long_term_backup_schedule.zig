const RepeatCadence = @import("repeat_cadence.zig").RepeatCadence;

/// The long-term backup schedule for an Autonomous Database.
pub const LongTermBackupSchedule = struct {
    /// Indicates whether the long-term backup schedule is disabled.
    is_disabled: ?bool = null,

    /// The cadence at which long-term backups are taken.
    repeat_cadence: ?RepeatCadence = null,

    /// The retention period, in days, for long-term backups.
    retention_period_in_days: ?i32 = null,

    /// The date and time at which the long-term backup is taken.
    time_of_backup: ?i64 = null,

    pub const json_field_names = .{
        .is_disabled = "isDisabled",
        .repeat_cadence = "repeatCadence",
        .retention_period_in_days = "retentionPeriodInDays",
        .time_of_backup = "timeOfBackup",
    };
};
