pub const RemediationExecutionStepState = enum {
    succeeded,
    pending,
    failed,
    in_progress,
    exited,
    unknown,

    pub const json_field_names = .{
        .succeeded = "SUCCEEDED",
        .pending = "PENDING",
        .failed = "FAILED",
        .in_progress = "IN_PROGRESS",
        .exited = "EXITED",
        .unknown = "UNKNOWN",
    };
};
