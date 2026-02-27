pub const TaskExecutionStatus = enum {
    queued,
    cancelling,
    launching,
    preparing,
    transferring,
    verifying,
    success,
    @"error",

    pub const json_field_names = .{
        .queued = "QUEUED",
        .cancelling = "CANCELLING",
        .launching = "LAUNCHING",
        .preparing = "PREPARING",
        .transferring = "TRANSFERRING",
        .verifying = "VERIFYING",
        .success = "SUCCESS",
        .@"error" = "ERROR",
    };
};
