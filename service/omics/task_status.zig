pub const TaskStatus = enum {
    pending,
    starting,
    running,
    stopping,
    completed,
    cancelled,
    failed,

    pub const json_field_names = .{
        .pending = "PENDING",
        .starting = "STARTING",
        .running = "RUNNING",
        .stopping = "STOPPING",
        .completed = "COMPLETED",
        .cancelled = "CANCELLED",
        .failed = "FAILED",
    };
};
