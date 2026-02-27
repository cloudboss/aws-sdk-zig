pub const ConnectionAuthType = enum {
    basic,
    api_key,
    oauth2_client_credentials,
    none,
    iam,
    oauth2_authorization_code,

    pub const json_field_names = .{
        .basic = "BASIC",
        .api_key = "API_KEY",
        .oauth2_client_credentials = "OAUTH2_CLIENT_CREDENTIALS",
        .none = "NONE",
        .iam = "IAM",
        .oauth2_authorization_code = "OAUTH2_AUTHORIZATION_CODE",
    };
};
