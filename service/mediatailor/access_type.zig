pub const AccessType = enum {
    s3_sigv4,
    secrets_manager_access_token,
    autodetect_sigv4,

    pub const json_field_names = .{
        .s3_sigv4 = "S3_SIGV4",
        .secrets_manager_access_token = "SECRETS_MANAGER_ACCESS_TOKEN",
        .autodetect_sigv4 = "AUTODETECT_SIGV4",
    };
};
