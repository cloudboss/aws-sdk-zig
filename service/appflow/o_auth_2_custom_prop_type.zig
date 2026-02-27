pub const OAuth2CustomPropType = enum {
    token_url,
    auth_url,

    pub const json_field_names = .{
        .token_url = "TOKEN_URL",
        .auth_url = "AUTH_URL",
    };
};
