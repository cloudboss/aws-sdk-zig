pub const ConnectionAuthorizationType = enum {
    basic,
    oauth_client_credentials,
    api_key,

    pub const json_field_names = .{
        .basic = "BASIC",
        .oauth_client_credentials = "OAUTH_CLIENT_CREDENTIALS",
        .api_key = "API_KEY",
    };
};
