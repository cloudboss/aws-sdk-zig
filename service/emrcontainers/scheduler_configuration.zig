/// The scheduler configuration for a virtual cluster on Amazon EMR on EKS. It
/// controls how
/// many job runs can run concurrently and how many can wait in the queue. When
/// not set, no
/// concurrency or queue limits are applied.
pub const SchedulerConfiguration = struct {
    /// The maximum number of job runs that can be in the `RUNNING` state at any
    /// time
    /// for the virtual cluster. As running slots free up, queued job runs start
    /// automatically. If
    /// you omit this field, the service applies no concurrency limit.
    max_concurrent_job_runs: ?i32 = null,

    /// The maximum number of job runs that can be in the `PENDING` or
    /// `SUBMITTED` state at any time for the virtual cluster. When the queue is
    /// full,
    /// the service rejects `StartJobRun` requests with a `ValidationException`. If
    /// you omit
    /// this field, the service applies no queue-depth limit.
    max_in_queue_job_runs: ?i32 = null,

    pub const json_field_names = .{
        .max_concurrent_job_runs = "maxConcurrentJobRuns",
        .max_in_queue_job_runs = "maxInQueueJobRuns",
    };
};
