pub const VerificationStatus = enum {
    verified,
    verification_failed,
    not_verified,

    pub const json_field_names = .{
        .verified = "VERIFIED",
        .verification_failed = "VERIFICATION_FAILED",
        .not_verified = "NOT_VERIFIED",
    };
};
