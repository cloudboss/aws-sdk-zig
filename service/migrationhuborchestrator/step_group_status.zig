pub const StepGroupStatus = enum {
    awaiting_dependencies,
    ready,
    in_progress,
    completed,
    failed,
    paused,
    pausing,
    user_attention_required,

    pub const json_field_names = .{
        .awaiting_dependencies = "AWAITING_DEPENDENCIES",
        .ready = "READY",
        .in_progress = "IN_PROGRESS",
        .completed = "COMPLETED",
        .failed = "FAILED",
        .paused = "PAUSED",
        .pausing = "PAUSING",
        .user_attention_required = "USER_ATTENTION_REQUIRED",
    };
};
