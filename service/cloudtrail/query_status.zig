pub const QueryStatus = enum {
    queued,
    running,
    finished,
    failed,
    cancelled,
    timed_out,

    pub const json_field_names = .{
        .queued = "QUEUED",
        .running = "RUNNING",
        .finished = "FINISHED",
        .failed = "FAILED",
        .cancelled = "CANCELLED",
        .timed_out = "TIMED_OUT",
    };
};
