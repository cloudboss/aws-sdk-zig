pub const JobStatus = enum {
    /// The Job has been submitted to run
    submitted,
    /// The Job is executing
    in_progress,
    /// The Job was cancelled
    cancelled,
    /// The Job has completed
    completed,
    /// The Job failed
    failed,
    /// The Job completed with failed runs
    completed_with_failures,

    pub const json_field_names = .{
        .submitted = "SUBMITTED",
        .in_progress = "IN_PROGRESS",
        .cancelled = "CANCELLED",
        .completed = "COMPLETED",
        .failed = "FAILED",
        .completed_with_failures = "COMPLETED_WITH_FAILURES",
    };
};
