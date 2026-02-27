pub const RestoreJobStatus = enum {
    pending,
    running,
    completed,
    aborted,
    failed,

    pub const json_field_names = .{
        .pending = "PENDING",
        .running = "RUNNING",
        .completed = "COMPLETED",
        .aborted = "ABORTED",
        .failed = "FAILED",
    };
};
