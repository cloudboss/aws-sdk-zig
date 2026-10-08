/// Defines data recovery targets for a resilience policy.
pub const DataRecoveryTargets = struct {
    /// The target time between backups, in minutes.
    time_between_backups_in_minutes: ?i32 = null,

    pub const json_field_names = .{
        .time_between_backups_in_minutes = "timeBetweenBackupsInMinutes",
    };
};
