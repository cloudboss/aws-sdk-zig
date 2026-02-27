const JobTimers = @import("job_timers.zig").JobTimers;

/// Describes the total number of tasks that the specified job has started, the
/// number of
/// tasks that succeeded, and the number of tasks that failed.
pub const JobProgressSummary = struct {
    number_of_tasks_failed: ?i64,

    number_of_tasks_succeeded: ?i64,

    /// The JobTimers attribute of a job's progress summary.
    timers: ?JobTimers,

    total_number_of_tasks: ?i64,
};
