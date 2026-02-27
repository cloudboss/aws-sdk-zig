pub const OAuth2GrantType = enum {
    client_credentials,
    authorization_code,
    jwt_bearer,

    pub const json_field_names = .{
        .client_credentials = "CLIENT_CREDENTIALS",
        .authorization_code = "AUTHORIZATION_CODE",
        .jwt_bearer = "JWT_BEARER",
    };
};
