pub const PipelineExecutionStatus = enum {
    cancelled,
    in_progress,
    stopped,
    stopping,
    succeeded,
    superseded,
    failed,

    pub const json_field_names = .{
        .cancelled = "Cancelled",
        .in_progress = "InProgress",
        .stopped = "Stopped",
        .stopping = "Stopping",
        .succeeded = "Succeeded",
        .superseded = "Superseded",
        .failed = "Failed",
    };
};
