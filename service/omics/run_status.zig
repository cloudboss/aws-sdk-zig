pub const RunStatus = enum {
    pending,
    starting,
    running,
    stopping,
    completed,
    deleted,
    cancelled,
    failed,

    pub const json_field_names = .{
        .pending = "PENDING",
        .starting = "STARTING",
        .running = "RUNNING",
        .stopping = "STOPPING",
        .completed = "COMPLETED",
        .deleted = "DELETED",
        .cancelled = "CANCELLED",
        .failed = "FAILED",
    };
};
