pub const Status = enum {
    failed,
    in_progress,
    pending,
    completed,
    updated_optimizing,
    optimizing,
    paused,
    cancelled,

    pub const json_field_names = .{
        .failed = "FAILED",
        .in_progress = "IN_PROGRESS",
        .pending = "PENDING",
        .completed = "COMPLETED",
        .updated_optimizing = "UPDATED_OPTIMIZING",
        .optimizing = "OPTIMIZING",
        .paused = "PAUSED",
        .cancelled = "CANCELLED",
    };
};
