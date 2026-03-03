const PointInTimeRecoveryStatus = @import("point_in_time_recovery_status.zig").PointInTimeRecoveryStatus;

/// The description of the point in time settings applied to the table.
pub const PointInTimeRecoveryDescription = struct {
    /// Specifies the earliest point in time you can restore your table to. You can
    /// restore
    /// your table to any point in time during the last 35 days.
    earliest_restorable_date_time: ?i64 = null,

    /// `LatestRestorableDateTime` is typically 5 minutes before the current time.
    latest_restorable_date_time: ?i64 = null,

    /// The current state of point in time recovery:
    ///
    /// * `ENABLED` - Point in time recovery is enabled.
    ///
    /// * `DISABLED` - Point in time recovery is disabled.
    point_in_time_recovery_status: ?PointInTimeRecoveryStatus = null,

    /// The number of preceding days for which continuous backups are taken and
    /// maintained.
    /// Your table data is only recoverable to any point-in-time from within the
    /// configured
    /// recovery period. This parameter is optional.
    recovery_period_in_days: ?i32 = null,

    pub const json_field_names = .{
        .earliest_restorable_date_time = "EarliestRestorableDateTime",
        .latest_restorable_date_time = "LatestRestorableDateTime",
        .point_in_time_recovery_status = "PointInTimeRecoveryStatus",
        .recovery_period_in_days = "RecoveryPeriodInDays",
    };
};
