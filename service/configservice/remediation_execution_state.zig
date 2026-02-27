pub const RemediationExecutionState = enum {
    queued,
    in_progress,
    succeeded,
    failed,
    unknown,

    pub const json_field_names = .{
        .queued = "QUEUED",
        .in_progress = "IN_PROGRESS",
        .succeeded = "SUCCEEDED",
        .failed = "FAILED",
        .unknown = "UNKNOWN",
    };
};
