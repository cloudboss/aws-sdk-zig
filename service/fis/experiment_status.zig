pub const ExperimentStatus = enum {
    pending,
    initiating,
    running,
    completed,
    stopping,
    stopped,
    failed,
    cancelled,

    pub const json_field_names = .{
        .pending = "pending",
        .initiating = "initiating",
        .running = "running",
        .completed = "completed",
        .stopping = "stopping",
        .stopped = "stopped",
        .failed = "failed",
        .cancelled = "cancelled",
    };
};
