pub const PropertyType = enum {
    user_input,
    secret,
    read_only,
    unused,
    secret_or_user_input,

    pub const json_field_names = .{
        .user_input = "USER_INPUT",
        .secret = "SECRET",
        .read_only = "READ_ONLY",
        .unused = "UNUSED",
        .secret_or_user_input = "SECRET_OR_USER_INPUT",
    };
};
