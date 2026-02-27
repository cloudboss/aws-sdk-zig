pub const MediaPipelineTaskStatus = enum {
    not_started,
    initializing,
    in_progress,
    failed,
    stopping,
    stopped,

    pub const json_field_names = .{
        .not_started = "NotStarted",
        .initializing = "Initializing",
        .in_progress = "InProgress",
        .failed = "Failed",
        .stopping = "Stopping",
        .stopped = "Stopped",
    };
};
