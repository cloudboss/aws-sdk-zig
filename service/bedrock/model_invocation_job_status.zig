pub const ModelInvocationJobStatus = enum {
    submitted,
    in_progress,
    completed,
    failed,
    stopping,
    stopped,
    partially_completed,
    expired,
    validating,
    scheduled,

    pub const json_field_names = .{
        .submitted = "SUBMITTED",
        .in_progress = "IN_PROGRESS",
        .completed = "COMPLETED",
        .failed = "FAILED",
        .stopping = "STOPPING",
        .stopped = "STOPPED",
        .partially_completed = "PARTIALLY_COMPLETED",
        .expired = "EXPIRED",
        .validating = "VALIDATING",
        .scheduled = "SCHEDULED",
    };
};
