pub const AutomatedReasoningPolicyTestRunStatus = enum {
    not_started,
    scheduled,
    in_progress,
    completed,
    failed,

    pub const json_field_names = .{
        .not_started = "NOT_STARTED",
        .scheduled = "SCHEDULED",
        .in_progress = "IN_PROGRESS",
        .completed = "COMPLETED",
        .failed = "FAILED",
    };
};
