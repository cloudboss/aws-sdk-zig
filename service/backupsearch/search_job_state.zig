pub const SearchJobState = enum {
    running,
    completed,
    stopping,
    stopped,
    failed,

    pub const json_field_names = .{
        .running = "RUNNING",
        .completed = "COMPLETED",
        .stopping = "STOPPING",
        .stopped = "STOPPED",
        .failed = "FAILED",
    };
};
