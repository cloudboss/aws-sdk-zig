pub const VerifiedAttributeType = enum {
    phone_number,
    email,

    pub const json_field_names = .{
        .phone_number = "PHONE_NUMBER",
        .email = "EMAIL",
    };
};
