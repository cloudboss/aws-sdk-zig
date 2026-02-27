pub const RetrievalStatus = enum {
    scheduled,
    running,
    complete,
    failed,
    cancelled,
    timeout,

    pub const json_field_names = .{
        .scheduled = "SCHEDULED",
        .running = "RUNNING",
        .complete = "COMPLETE",
        .failed = "FAILED",
        .cancelled = "CANCELLED",
        .timeout = "TIMEOUT",
    };
};
