pub const EffectiveDeploymentExecutionStatus = enum {
    in_progress,
    queued,
    failed,
    completed,
    timed_out,
    canceled,
    rejected,
    succeeded,

    pub const json_field_names = .{
        .in_progress = "IN_PROGRESS",
        .queued = "QUEUED",
        .failed = "FAILED",
        .completed = "COMPLETED",
        .timed_out = "TIMED_OUT",
        .canceled = "CANCELED",
        .rejected = "REJECTED",
        .succeeded = "SUCCEEDED",
    };
};
