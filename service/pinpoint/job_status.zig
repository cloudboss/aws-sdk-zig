pub const JobStatus = enum {
    created,
    preparing_for_initialization,
    initializing,
    processing,
    pending_job,
    completing,
    completed,
    failing,
    failed,

    pub const json_field_names = .{
        .created = "CREATED",
        .preparing_for_initialization = "PREPARING_FOR_INITIALIZATION",
        .initializing = "INITIALIZING",
        .processing = "PROCESSING",
        .pending_job = "PENDING_JOB",
        .completing = "COMPLETING",
        .completed = "COMPLETED",
        .failing = "FAILING",
        .failed = "FAILED",
    };
};
