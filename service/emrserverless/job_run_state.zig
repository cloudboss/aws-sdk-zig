pub const JobRunState = enum {
    submitted,
    pending,
    scheduled,
    running,
    success,
    failed,
    cancelling,
    cancelled,
    queued,

    pub const json_field_names = .{
        .submitted = "SUBMITTED",
        .pending = "PENDING",
        .scheduled = "SCHEDULED",
        .running = "RUNNING",
        .success = "SUCCESS",
        .failed = "FAILED",
        .cancelling = "CANCELLING",
        .cancelled = "CANCELLED",
        .queued = "QUEUED",
    };
};
