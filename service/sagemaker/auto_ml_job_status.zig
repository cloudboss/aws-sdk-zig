pub const AutoMLJobStatus = enum {
    completed,
    in_progress,
    failed,
    stopped,
    stopping,

    pub const json_field_names = .{
        .completed = "COMPLETED",
        .in_progress = "IN_PROGRESS",
        .failed = "FAILED",
        .stopped = "STOPPED",
        .stopping = "STOPPING",
    };
};
