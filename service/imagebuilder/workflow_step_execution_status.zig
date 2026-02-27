pub const WorkflowStepExecutionStatus = enum {
    pending,
    skipped,
    running,
    completed,
    failed,
    cancelled,

    pub const json_field_names = .{
        .pending = "PENDING",
        .skipped = "SKIPPED",
        .running = "RUNNING",
        .completed = "COMPLETED",
        .failed = "FAILED",
        .cancelled = "CANCELLED",
    };
};
