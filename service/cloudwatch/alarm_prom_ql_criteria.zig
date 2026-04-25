/// Contains the configuration that determines how a PromQL alarm evaluates its
/// contributors, including the query to run and the durations that define when
/// contributors
/// transition between states.
pub const AlarmPromQLCriteria = struct {
    /// The duration, in seconds, that a contributor must be continuously breaching
    /// before
    /// it transitions to the `ALARM` state.
    pending_period: ?i32 = null,

    /// The PromQL query that the alarm evaluates. The query must return a result of
    /// vector
    /// type. Each entry in the vector result represents an alarm contributor.
    query: []const u8,

    /// The duration, in seconds, that a contributor must continuously not be
    /// breaching
    /// before it transitions back to the `OK` state.
    recovery_period: ?i32 = null,

    pub const json_field_names = .{
        .pending_period = "PendingPeriod",
        .query = "Query",
        .recovery_period = "RecoveryPeriod",
    };
};
