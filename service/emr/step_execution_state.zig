pub const StepExecutionState = enum {
    pending,
    running,
    @"continue",
    completed,
    cancelled,
    failed,
    interrupted,

    pub const json_field_names = .{
        .pending = "PENDING",
        .running = "RUNNING",
        .@"continue" = "CONTINUE",
        .completed = "COMPLETED",
        .cancelled = "CANCELLED",
        .failed = "FAILED",
        .interrupted = "INTERRUPTED",
    };
};
