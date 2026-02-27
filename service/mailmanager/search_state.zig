pub const SearchState = enum {
    queued,
    running,
    completed,
    failed,
    cancelled,

    pub const json_field_names = .{
        .queued = "QUEUED",
        .running = "RUNNING",
        .completed = "COMPLETED",
        .failed = "FAILED",
        .cancelled = "CANCELLED",
    };
};
