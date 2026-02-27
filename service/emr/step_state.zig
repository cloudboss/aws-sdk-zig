pub const StepState = enum {
    pending,
    cancel_pending,
    running,
    completed,
    cancelled,
    failed,
    interrupted,

    pub const json_field_names = .{
        .pending = "PENDING",
        .cancel_pending = "CANCEL_PENDING",
        .running = "RUNNING",
        .completed = "COMPLETED",
        .cancelled = "CANCELLED",
        .failed = "FAILED",
        .interrupted = "INTERRUPTED",
    };
};
