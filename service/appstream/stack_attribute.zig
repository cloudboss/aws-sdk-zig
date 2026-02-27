pub const StackAttribute = enum {
    storage_connectors,
    storage_connector_homefolders,
    storage_connector_google_drive,
    storage_connector_one_drive,
    redirect_url,
    feedback_url,
    theme_name,
    user_settings,
    embed_host_domains,
    iam_role_arn,
    access_endpoints,
    streaming_experience_settings,

    pub const json_field_names = .{
        .storage_connectors = "STORAGE_CONNECTORS",
        .storage_connector_homefolders = "STORAGE_CONNECTOR_HOMEFOLDERS",
        .storage_connector_google_drive = "STORAGE_CONNECTOR_GOOGLE_DRIVE",
        .storage_connector_one_drive = "STORAGE_CONNECTOR_ONE_DRIVE",
        .redirect_url = "REDIRECT_URL",
        .feedback_url = "FEEDBACK_URL",
        .theme_name = "THEME_NAME",
        .user_settings = "USER_SETTINGS",
        .embed_host_domains = "EMBED_HOST_DOMAINS",
        .iam_role_arn = "IAM_ROLE_ARN",
        .access_endpoints = "ACCESS_ENDPOINTS",
        .streaming_experience_settings = "STREAMING_EXPERIENCE_SETTINGS",
    };
};
