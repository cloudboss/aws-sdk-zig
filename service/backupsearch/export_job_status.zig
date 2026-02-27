pub const ExportJobStatus = enum {
    running,
    failed,
    completed,

    pub const json_field_names = .{
        .running = "RUNNING",
        .failed = "FAILED",
        .completed = "COMPLETED",
    };
};
