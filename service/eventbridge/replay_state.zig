pub const ReplayState = enum {
    starting,
    running,
    cancelling,
    completed,
    cancelled,
    failed,

    pub const json_field_names = .{
        .starting = "STARTING",
        .running = "RUNNING",
        .cancelling = "CANCELLING",
        .completed = "COMPLETED",
        .cancelled = "CANCELLED",
        .failed = "FAILED",
    };
};
