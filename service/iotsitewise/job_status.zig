pub const JobStatus = enum {
    pending,
    cancelled,
    running,
    completed,
    failed,
    completed_with_failures,

    pub const json_field_names = .{
        .pending = "PENDING",
        .cancelled = "CANCELLED",
        .running = "RUNNING",
        .completed = "COMPLETED",
        .failed = "FAILED",
        .completed_with_failures = "COMPLETED_WITH_FAILURES",
    };
};
