pub const StepStatus = enum {
    awaiting_dependencies,
    skipped,
    ready,
    in_progress,
    completed,
    failed,
    paused,
    user_attention_required,

    pub const json_field_names = .{
        .awaiting_dependencies = "AWAITING_DEPENDENCIES",
        .skipped = "SKIPPED",
        .ready = "READY",
        .in_progress = "IN_PROGRESS",
        .completed = "COMPLETED",
        .failed = "FAILED",
        .paused = "PAUSED",
        .user_attention_required = "USER_ATTENTION_REQUIRED",
    };
};
