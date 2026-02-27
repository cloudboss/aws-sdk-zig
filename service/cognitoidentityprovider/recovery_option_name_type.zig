pub const RecoveryOptionNameType = enum {
    verified_email,
    verified_phone_number,
    admin_only,

    pub const json_field_names = .{
        .verified_email = "VERIFIED_EMAIL",
        .verified_phone_number = "VERIFIED_PHONE_NUMBER",
        .admin_only = "ADMIN_ONLY",
    };
};
