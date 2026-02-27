pub const LifecycleExecutionStatus = enum {
    in_progress,
    cancelled,
    cancelling,
    failed,
    success,
    pending,

    pub const json_field_names = .{
        .in_progress = "IN_PROGRESS",
        .cancelled = "CANCELLED",
        .cancelling = "CANCELLING",
        .failed = "FAILED",
        .success = "SUCCESS",
        .pending = "PENDING",
    };
};
