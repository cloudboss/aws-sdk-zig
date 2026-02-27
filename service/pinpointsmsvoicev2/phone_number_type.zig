pub const PhoneNumberType = enum {
    mobile,
    landline,
    other,
    invalid,

    pub const json_field_names = .{
        .mobile = "MOBILE",
        .landline = "LANDLINE",
        .other = "OTHER",
        .invalid = "INVALID",
    };
};
