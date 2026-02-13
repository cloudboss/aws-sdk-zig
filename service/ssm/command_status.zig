pub const CommandStatus = enum {
    pending,
    in_progress,
    success,
    cancelled,
    failed,
    timed_out,
    cancelling,

    pub const json_field_names = .{
        .pending = "PENDING",
        .in_progress = "IN_PROGRESS",
        .success = "SUCCESS",
        .cancelled = "CANCELLED",
        .failed = "FAILED",
        .timed_out = "TIMED_OUT",
        .cancelling = "CANCELLING",
    };
};
