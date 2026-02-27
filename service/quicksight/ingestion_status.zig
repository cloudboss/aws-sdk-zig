pub const IngestionStatus = enum {
    initialized,
    queued,
    running,
    failed,
    completed,
    cancelled,

    pub const json_field_names = .{
        .initialized = "INITIALIZED",
        .queued = "QUEUED",
        .running = "RUNNING",
        .failed = "FAILED",
        .completed = "COMPLETED",
        .cancelled = "CANCELLED",
    };
};
