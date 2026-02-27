pub const SharePointAuthType = enum {
    oauth2_client_credentials,
    oauth2_sharepoint_app_only_client_credentials,

    pub const json_field_names = .{
        .oauth2_client_credentials = "OAUTH2_CLIENT_CREDENTIALS",
        .oauth2_sharepoint_app_only_client_credentials = "OAUTH2_SHAREPOINT_APP_ONLY_CLIENT_CREDENTIALS",
    };
};
