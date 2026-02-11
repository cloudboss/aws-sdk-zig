/// Represents the settings used to enable point in time recovery.
pub const PointInTimeRecoverySpecification = struct {
    /// Indicates whether point in time recovery is enabled (true) or disabled
    /// (false) on the
    /// table.
    point_in_time_recovery_enabled: bool,

    /// The number of preceding days for which continuous backups are taken and
    /// maintained.
    /// Your table data is only recoverable to any point-in-time from within the
    /// configured
    /// recovery period. This parameter is optional. If no value is provided, the
    /// value will
    /// default to 35.
    recovery_period_in_days: ?i32,

    pub const json_field_names = .{
        .point_in_time_recovery_enabled = "PointInTimeRecoveryEnabled",
        .recovery_period_in_days = "RecoveryPeriodInDays",
    };
};
