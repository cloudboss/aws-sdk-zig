pub const CopyJobState = enum {
    created,
    running,
    completed,
    failed,
    partial,

    pub const json_field_names = .{
        .created = "CREATED",
        .running = "RUNNING",
        .completed = "COMPLETED",
        .failed = "FAILED",
        .partial = "PARTIAL",
    };
};
