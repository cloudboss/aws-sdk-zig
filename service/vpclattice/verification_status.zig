pub const VerificationStatus = enum {
    verified,
    pending,
    verification_timed_out,

    pub const json_field_names = .{
        .verified = "VERIFIED",
        .pending = "PENDING",
        .verification_timed_out = "VERIFICATION_TIMED_OUT",
    };
};
