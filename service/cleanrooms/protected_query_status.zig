pub const ProtectedQueryStatus = enum {
    submitted,
    started,
    cancelled,
    cancelling,
    failed,
    success,
    timed_out,

    pub const json_field_names = .{
        .submitted = "SUBMITTED",
        .started = "STARTED",
        .cancelled = "CANCELLED",
        .cancelling = "CANCELLING",
        .failed = "FAILED",
        .success = "SUCCESS",
        .timed_out = "TIMED_OUT",
    };
};
