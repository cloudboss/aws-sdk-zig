pub const BatchJobExecutionStatus = enum {
    submitting,
    holding,
    dispatch,
    running,
    cancelling,
    cancelled,
    succeeded,
    failed,
    purged,
    succeeded_with_warning,

    pub const json_field_names = .{
        .submitting = "SUBMITTING",
        .holding = "HOLDING",
        .dispatch = "DISPATCH",
        .running = "RUNNING",
        .cancelling = "CANCELLING",
        .cancelled = "CANCELLED",
        .succeeded = "SUCCEEDED",
        .failed = "FAILED",
        .purged = "PURGED",
        .succeeded_with_warning = "SUCCEEDED_WITH_WARNING",
    };
};
