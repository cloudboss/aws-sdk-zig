pub const MediaPipelineStatus = enum {
    initializing,
    in_progress,
    failed,
    stopping,
    stopped,
    paused,
    not_started,

    pub const json_field_names = .{
        .initializing = "Initializing",
        .in_progress = "InProgress",
        .failed = "Failed",
        .stopping = "Stopping",
        .stopped = "Stopped",
        .paused = "Paused",
        .not_started = "NotStarted",
    };
};
