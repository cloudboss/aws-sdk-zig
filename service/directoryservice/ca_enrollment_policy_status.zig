pub const CaEnrollmentPolicyStatus = enum {
    in_progress,
    success,
    failed,
    disabling,
    disabled,
    impaired,

    pub const json_field_names = .{
        .in_progress = "IN_PROGRESS",
        .success = "SUCCESS",
        .failed = "FAILED",
        .disabling = "DISABLING",
        .disabled = "DISABLED",
        .impaired = "IMPAIRED",
    };
};
