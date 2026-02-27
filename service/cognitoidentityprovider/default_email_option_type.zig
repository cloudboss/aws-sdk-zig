pub const DefaultEmailOptionType = enum {
    confirm_with_link,
    confirm_with_code,

    pub const json_field_names = .{
        .confirm_with_link = "CONFIRM_WITH_LINK",
        .confirm_with_code = "CONFIRM_WITH_CODE",
    };
};
