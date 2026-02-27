pub const SalesforceAuthType = enum {
    oauth2_client_credentials,

    pub const json_field_names = .{
        .oauth2_client_credentials = "OAUTH2_CLIENT_CREDENTIALS",
    };
};
