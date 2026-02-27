pub const WorkflowStepExecutionRollbackStatus = enum {
    running,
    completed,
    skipped,
    failed,

    pub const json_field_names = .{
        .running = "RUNNING",
        .completed = "COMPLETED",
        .skipped = "SKIPPED",
        .failed = "FAILED",
    };
};
