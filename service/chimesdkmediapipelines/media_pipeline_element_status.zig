pub const MediaPipelineElementStatus = enum {
    not_started,
    not_supported,
    initializing,
    in_progress,
    failed,
    stopping,
    stopped,
    paused,

    pub const json_field_names = .{
        .not_started = "NotStarted",
        .not_supported = "NotSupported",
        .initializing = "Initializing",
        .in_progress = "InProgress",
        .failed = "Failed",
        .stopping = "Stopping",
        .stopped = "Stopped",
        .paused = "Paused",
    };
};
