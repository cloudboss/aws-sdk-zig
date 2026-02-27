pub const ConfluenceAuthType = enum {
    basic,
    oauth2_client_credentials,

    pub const json_field_names = .{
        .basic = "BASIC",
        .oauth2_client_credentials = "OAUTH2_CLIENT_CREDENTIALS",
    };
};
