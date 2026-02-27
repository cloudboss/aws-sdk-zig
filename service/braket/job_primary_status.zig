pub const JobPrimaryStatus = enum {
    queued,
    running,
    completed,
    failed,
    cancelling,
    cancelled,

    pub const json_field_names = .{
        .queued = "QUEUED",
        .running = "RUNNING",
        .completed = "COMPLETED",
        .failed = "FAILED",
        .cancelling = "CANCELLING",
        .cancelled = "CANCELLED",
    };
};
