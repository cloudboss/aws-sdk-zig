pub const ExecutionState = enum {
    queued,
    in_progress,
    canceled,
    failed,
    succeeded,
    rejected,
    timed_out,

    pub const json_field_names = .{
        .queued = "QUEUED",
        .in_progress = "IN_PROGRESS",
        .canceled = "CANCELED",
        .failed = "FAILED",
        .succeeded = "SUCCEEDED",
        .rejected = "REJECTED",
        .timed_out = "TIMED_OUT",
    };
};
