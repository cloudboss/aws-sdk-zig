pub const PhoneNumberType = enum {
    local,
    toll_free,

    pub const json_field_names = .{
        .local = "Local",
        .toll_free = "TollFree",
    };
};
