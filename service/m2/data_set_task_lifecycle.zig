pub const DataSetTaskLifecycle = enum {
    creating,
    running,
    completed,
    failed,

    pub const json_field_names = .{
        .creating = "CREATING",
        .running = "RUNNING",
        .completed = "COMPLETED",
        .failed = "FAILED",
    };
};
