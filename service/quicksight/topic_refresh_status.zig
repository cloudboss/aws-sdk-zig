pub const TopicRefreshStatus = enum {
    initialized,
    running,
    failed,
    completed,
    cancelled,

    pub const json_field_names = .{
        .initialized = "INITIALIZED",
        .running = "RUNNING",
        .failed = "FAILED",
        .completed = "COMPLETED",
        .cancelled = "CANCELLED",
    };
};
