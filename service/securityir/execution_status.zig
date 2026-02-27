pub const ExecutionStatus = enum {
    pending,
    in_progress,
    waiting,
    completed,
    failed,
    cancelled,

    pub const json_field_names = .{
        .pending = "PENDING",
        .in_progress = "IN_PROGRESS",
        .waiting = "WAITING",
        .completed = "COMPLETED",
        .failed = "FAILED",
        .cancelled = "CANCELLED",
    };
};
