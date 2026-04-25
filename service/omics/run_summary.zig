/// A summary of the runs in a batch.
pub const RunSummary = struct {
    /// The number of cancelled runs.
    cancelled_run_count: ?i32 = null,

    /// The number of completed runs.
    completed_run_count: ?i32 = null,

    /// The number of deleted runs.
    deleted_run_count: ?i32 = null,

    /// The number of failed runs.
    failed_run_count: ?i32 = null,

    /// The number of pending runs.
    pending_run_count: ?i32 = null,

    /// The number of running runs.
    running_run_count: ?i32 = null,

    /// The number of starting runs.
    starting_run_count: ?i32 = null,

    /// The number of stopping runs.
    stopping_run_count: ?i32 = null,

    pub const json_field_names = .{
        .cancelled_run_count = "cancelledRunCount",
        .completed_run_count = "completedRunCount",
        .deleted_run_count = "deletedRunCount",
        .failed_run_count = "failedRunCount",
        .pending_run_count = "pendingRunCount",
        .running_run_count = "runningRunCount",
        .starting_run_count = "startingRunCount",
        .stopping_run_count = "stoppingRunCount",
    };
};
