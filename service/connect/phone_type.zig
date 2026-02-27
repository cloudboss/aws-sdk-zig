pub const PhoneType = enum {
    soft_phone,
    desk_phone,

    pub const json_field_names = .{
        .soft_phone = "SOFT_PHONE",
        .desk_phone = "DESK_PHONE",
    };
};
