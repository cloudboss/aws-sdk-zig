pub const OAuthGrantType = enum {
    client_credentials,
    authorization_code,

    pub const json_field_names = .{
        .client_credentials = "CLIENT_CREDENTIALS",
        .authorization_code = "AUTHORIZATION_CODE",
    };
};
