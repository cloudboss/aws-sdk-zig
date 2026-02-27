pub const ExecutionStatus = enum {
    pending,
    completed,
    completed_with_violations,
    in_progress,
    failed,
    stopping,
    stopped,

    pub const json_field_names = .{
        .pending = "PENDING",
        .completed = "COMPLETED",
        .completed_with_violations = "COMPLETED_WITH_VIOLATIONS",
        .in_progress = "IN_PROGRESS",
        .failed = "FAILED",
        .stopping = "STOPPING",
        .stopped = "STOPPED",
    };
};
