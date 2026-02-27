pub const VerificationStatus = enum {
    pending,
    verified,

    pub const json_field_names = .{
        .pending = "PENDING",
        .verified = "VERIFIED",
    };
};
