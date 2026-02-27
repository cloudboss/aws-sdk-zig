pub const ExperimentActionStatus = enum {
    pending,
    initiating,
    running,
    completed,
    cancelled,
    stopping,
    stopped,
    failed,
    skipped,

    pub const json_field_names = .{
        .pending = "pending",
        .initiating = "initiating",
        .running = "running",
        .completed = "completed",
        .cancelled = "cancelled",
        .stopping = "stopping",
        .stopped = "stopped",
        .failed = "failed",
        .skipped = "skipped",
    };
};
