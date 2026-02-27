pub const RestoreValidationStatus = enum {
    failed,
    successful,
    timed_out,
    validating,

    pub const json_field_names = .{
        .failed = "FAILED",
        .successful = "SUCCESSFUL",
        .timed_out = "TIMED_OUT",
        .validating = "VALIDATING",
    };
};
