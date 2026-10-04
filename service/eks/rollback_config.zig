/// The rollback configuration for the cluster version rollback.
pub const RollbackConfig = struct {
    /// The length of time in minutes to wait before cancelling the update. Timeout
    /// is a
    /// minimum-bound property, meaning the timeout occurs no sooner than the time
    /// you specify,
    /// but can occur shortly thereafter. This value can be between 120 (2 hours)
    /// and 10080
    /// (7 days). Default: `720` (12 hours) if not specified.
    timeout_minutes: ?i32 = null,

    pub const json_field_names = .{
        .timeout_minutes = "timeoutMinutes",
    };
};
