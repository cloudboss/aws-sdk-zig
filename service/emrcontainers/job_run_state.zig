pub const JobRunState = enum {
    pending,
    submitted,
    running,
    failed,
    cancelled,
    cancel_pending,
    completed,

    pub const json_field_names = .{
        .pending = "PENDING",
        .submitted = "SUBMITTED",
        .running = "RUNNING",
        .failed = "FAILED",
        .cancelled = "CANCELLED",
        .cancel_pending = "CANCEL_PENDING",
        .completed = "COMPLETED",
    };
};
