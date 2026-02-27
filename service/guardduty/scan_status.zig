pub const ScanStatus = enum {
    running,
    completed,
    failed,
    skipped,

    pub const json_field_names = .{
        .running = "RUNNING",
        .completed = "COMPLETED",
        .failed = "FAILED",
        .skipped = "SKIPPED",
    };
};
