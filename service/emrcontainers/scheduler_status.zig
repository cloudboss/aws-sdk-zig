/// The current job-run counts for a virtual cluster, reflecting how much of the
/// configured
/// scheduler capacity is in use.
pub const SchedulerStatus = struct {
    /// The number of job runs currently in the `RUNNING` state for the virtual
    /// cluster.
    current_concurrent_job_runs: i32 = 0,

    /// The number of job runs currently waiting in the queue (`PENDING` or
    /// `SUBMITTED`) for the virtual cluster.
    current_in_queue_job_runs: i32 = 0,

    pub const json_field_names = .{
        .current_concurrent_job_runs = "currentConcurrentJobRuns",
        .current_in_queue_job_runs = "currentInQueueJobRuns",
    };
};
