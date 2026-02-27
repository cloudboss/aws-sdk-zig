pub const OAuth2GrantType = enum {
    authorization_code,
    client_credentials,
    jwt_bearer,

    pub const json_field_names = .{
        .authorization_code = "AUTHORIZATION_CODE",
        .client_credentials = "CLIENT_CREDENTIALS",
        .jwt_bearer = "JWT_BEARER",
    };
};
