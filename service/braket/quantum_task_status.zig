pub const QuantumTaskStatus = enum {
    created,
    queued,
    running,
    completed,
    failed,
    cancelling,
    cancelled,

    pub const json_field_names = .{
        .created = "CREATED",
        .queued = "QUEUED",
        .running = "RUNNING",
        .completed = "COMPLETED",
        .failed = "FAILED",
        .cancelling = "CANCELLING",
        .cancelled = "CANCELLED",
    };
};
