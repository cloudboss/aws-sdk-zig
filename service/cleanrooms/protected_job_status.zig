pub const ProtectedJobStatus = enum {
    submitted,
    started,
    cancelled,
    cancelling,
    failed,
    success,

    pub const json_field_names = .{
        .submitted = "SUBMITTED",
        .started = "STARTED",
        .cancelled = "CANCELLED",
        .cancelling = "CANCELLING",
        .failed = "FAILED",
        .success = "SUCCESS",
    };
};
