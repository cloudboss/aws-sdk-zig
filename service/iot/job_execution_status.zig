pub const JobExecutionStatus = enum {
    queued,
    in_progress,
    succeeded,
    failed,
    timed_out,
    rejected,
    removed,
    canceled,

    pub const json_field_names = .{
        .queued = "QUEUED",
        .in_progress = "IN_PROGRESS",
        .succeeded = "SUCCEEDED",
        .failed = "FAILED",
        .timed_out = "TIMED_OUT",
        .rejected = "REJECTED",
        .removed = "REMOVED",
        .canceled = "CANCELED",
    };
};
