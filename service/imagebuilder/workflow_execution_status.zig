pub const WorkflowExecutionStatus = enum {
    pending,
    skipped,
    running,
    completed,
    failed,
    rollback_in_progress,
    rollback_completed,
    cancelled,

    pub const json_field_names = .{
        .pending = "PENDING",
        .skipped = "SKIPPED",
        .running = "RUNNING",
        .completed = "COMPLETED",
        .failed = "FAILED",
        .rollback_in_progress = "ROLLBACK_IN_PROGRESS",
        .rollback_completed = "ROLLBACK_COMPLETED",
        .cancelled = "CANCELLED",
    };
};
