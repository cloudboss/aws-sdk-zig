pub const UserContextPolicy = enum {
    attribute_filter,
    user_token,

    pub const json_field_names = .{
        .attribute_filter = "ATTRIBUTE_FILTER",
        .user_token = "USER_TOKEN",
    };
};
