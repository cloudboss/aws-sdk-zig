pub const CommandInvocationStatus = enum {
    pending,
    in_progress,
    delayed,
    success,
    cancelled,
    timed_out,
    failed,
    cancelling,

    pub const json_field_names = .{
        .pending = "PENDING",
        .in_progress = "IN_PROGRESS",
        .delayed = "DELAYED",
        .success = "SUCCESS",
        .cancelled = "CANCELLED",
        .timed_out = "TIMED_OUT",
        .failed = "FAILED",
        .cancelling = "CANCELLING",
    };
};
