pub const MfaTypesElement = enum {
    sms,
    totp,

    pub const json_field_names = .{
        .sms = "SMS",
        .totp = "TOTP",
    };
};
