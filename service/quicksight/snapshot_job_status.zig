pub const SnapshotJobStatus = enum {
    queued,
    running,
    completed,
    failed,

    pub const json_field_names = .{
        .queued = "QUEUED",
        .running = "RUNNING",
        .completed = "COMPLETED",
        .failed = "FAILED",
    };
};
