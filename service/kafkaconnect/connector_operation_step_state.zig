pub const ConnectorOperationStepState = enum {
    pending,
    in_progress,
    completed,
    failed,
    cancelled,

    pub const json_field_names = .{
        .pending = "PENDING",
        .in_progress = "IN_PROGRESS",
        .completed = "COMPLETED",
        .failed = "FAILED",
        .cancelled = "CANCELLED",
    };
};
