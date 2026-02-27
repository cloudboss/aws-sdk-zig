pub const ConnectorOAuth2GrantType = enum {
    client_credentials,
    jwt_bearer,
    authorization_code,

    pub const json_field_names = .{
        .client_credentials = "CLIENT_CREDENTIALS",
        .jwt_bearer = "JWT_BEARER",
        .authorization_code = "AUTHORIZATION_CODE",
    };
};
