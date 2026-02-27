pub const VerificationStatus = enum {
    pending,
    success,
    failed,
    temporary_failure,
    not_started,

    pub const json_field_names = .{
        .pending = "PENDING",
        .success = "SUCCESS",
        .failed = "FAILED",
        .temporary_failure = "TEMPORARY_FAILURE",
        .not_started = "NOT_STARTED",
    };
};
