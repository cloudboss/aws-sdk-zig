pub const RedisAuthTypeValue = enum {
    none,
    auth_role,
    auth_token,

    pub const json_field_names = .{
        .none = "NONE",
        .auth_role = "AUTH_ROLE",
        .auth_token = "AUTH_TOKEN",
    };
};
