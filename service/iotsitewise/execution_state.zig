pub const ExecutionState = enum {
    running,
    completed,
    failed,

    pub const json_field_names = .{
        .running = "RUNNING",
        .completed = "COMPLETED",
        .failed = "FAILED",
    };
};
