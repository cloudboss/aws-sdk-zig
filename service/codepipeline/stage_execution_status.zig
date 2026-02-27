pub const StageExecutionStatus = enum {
    cancelled,
    in_progress,
    failed,
    stopped,
    stopping,
    succeeded,
    skipped,

    pub const json_field_names = .{
        .cancelled = "Cancelled",
        .in_progress = "InProgress",
        .failed = "Failed",
        .stopped = "Stopped",
        .stopping = "Stopping",
        .succeeded = "Succeeded",
        .skipped = "Skipped",
    };
};
