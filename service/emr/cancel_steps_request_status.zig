pub const CancelStepsRequestStatus = enum {
    submitted,
    failed,

    pub const json_field_names = .{
        .submitted = "SUBMITTED",
        .failed = "FAILED",
    };
};
