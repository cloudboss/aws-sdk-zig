pub const LabelingJobStatus = enum {
    initializing,
    in_progress,
    completed,
    failed,
    stopping,
    stopped,

    pub const json_field_names = .{
        .initializing = "INITIALIZING",
        .in_progress = "IN_PROGRESS",
        .completed = "COMPLETED",
        .failed = "FAILED",
        .stopping = "STOPPING",
        .stopped = "STOPPED",
    };
};
