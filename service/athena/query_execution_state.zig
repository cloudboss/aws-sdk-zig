pub const QueryExecutionState = enum {
    queued,
    running,
    succeeded,
    failed,
    cancelled,

    pub const json_field_names = .{
        .queued = "QUEUED",
        .running = "RUNNING",
        .succeeded = "SUCCEEDED",
        .failed = "FAILED",
        .cancelled = "CANCELLED",
    };
};
