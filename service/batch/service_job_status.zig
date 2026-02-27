pub const ServiceJobStatus = enum {
    submitted,
    pending,
    runnable,
    scheduled,
    starting,
    running,
    succeeded,
    failed,

    pub const json_field_names = .{
        .submitted = "SUBMITTED",
        .pending = "PENDING",
        .runnable = "RUNNABLE",
        .scheduled = "SCHEDULED",
        .starting = "STARTING",
        .running = "RUNNING",
        .succeeded = "SUCCEEDED",
        .failed = "FAILED",
    };
};
