pub const GrantType = enum {
    authorization_code,
    refresh_token,
    jwt_bearer,
    token_exchange,

    pub const json_field_names = .{
        .authorization_code = "AUTHORIZATION_CODE",
        .refresh_token = "REFRESH_TOKEN",
        .jwt_bearer = "JWT_BEARER",
        .token_exchange = "TOKEN_EXCHANGE",
    };
};
