pub const VerificationType = enum {
    business_verification,
    registrant_verification,

    pub const json_field_names = .{
        .business_verification = "BUSINESS_VERIFICATION",
        .registrant_verification = "REGISTRANT_VERIFICATION",
    };
};
