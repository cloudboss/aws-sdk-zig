pub const ImportStatus = enum {
    initializing,
    in_progress,
    failed,
    stopped,
    completed,

    pub const json_field_names = .{
        .initializing = "INITIALIZING",
        .in_progress = "IN_PROGRESS",
        .failed = "FAILED",
        .stopped = "STOPPED",
        .completed = "COMPLETED",
    };
};
