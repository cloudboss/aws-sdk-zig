const FrontOfQueueJobSummary = @import("front_of_queue_job_summary.zig").FrontOfQueueJobSummary;

/// Contains a list of the first 100 `RUNNABLE` jobs associated to a single job
/// queue.
pub const FrontOfQueueDetail = struct {
    /// The Amazon Resource Names (ARNs) of the first 100 `RUNNABLE` jobs in a named
    /// job queue. For first-in-first-out (FIFO) job queues, jobs are ordered based
    /// on their submission time. For fair-share scheduling (FSS) job queues, jobs
    /// are ordered based on their job priority and share usage.
    jobs: ?[]const FrontOfQueueJobSummary = null,

    /// The Unix timestamp (in milliseconds) for when each of the first 100
    /// `RUNNABLE` jobs were last updated.
    last_updated_at: ?i64 = null,

    pub const json_field_names = .{
        .jobs = "jobs",
        .last_updated_at = "lastUpdatedAt",
    };
};
