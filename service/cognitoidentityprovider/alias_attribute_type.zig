pub const AliasAttributeType = enum {
    phone_number,
    email,
    preferred_username,

    pub const json_field_names = .{
        .phone_number = "PHONE_NUMBER",
        .email = "EMAIL",
        .preferred_username = "PREFERRED_USERNAME",
    };
};
