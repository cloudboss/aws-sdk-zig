pub const StepTargetTaskRunStatus = enum {
    ready,
    failed,
    succeeded,
    canceled,
    suspended,
    pending,

    pub const json_field_names = .{
        .ready = "READY",
        .failed = "FAILED",
        .succeeded = "SUCCEEDED",
        .canceled = "CANCELED",
        .suspended = "SUSPENDED",
        .pending = "PENDING",
    };
};
