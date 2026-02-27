pub const JobStatus = enum {
    submitted,
    pending,
    runnable,
    starting,
    running,
    succeeded,
    failed,

    pub const json_field_names = .{
        .submitted = "SUBMITTED",
        .pending = "PENDING",
        .runnable = "RUNNABLE",
        .starting = "STARTING",
        .running = "RUNNING",
        .succeeded = "SUCCEEDED",
        .failed = "FAILED",
    };
};
