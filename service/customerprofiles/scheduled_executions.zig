/// Information about scheduled execution timestamps.
pub const ScheduledExecutions = struct {
    /// The timestamp of the last successful scheduled execution.
    last_executed_at: ?i64 = null,

    /// The timestamp of the next scheduled execution.
    next_executed_at: ?i64 = null,

    pub const json_field_names = .{
        .last_executed_at = "LastExecutedAt",
        .next_executed_at = "NextExecutedAt",
    };
};
