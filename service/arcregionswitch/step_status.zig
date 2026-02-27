pub const StepStatus = enum {
    not_started,
    running,
    failed,
    completed,
    cancelled,
    skipped,
    pending_approval,

    pub const json_field_names = .{
        .not_started = "NOT_STARTED",
        .running = "RUNNING",
        .failed = "FAILED",
        .completed = "COMPLETED",
        .cancelled = "CANCELLED",
        .skipped = "SKIPPED",
        .pending_approval = "PENDING_APPROVAL",
    };
};
