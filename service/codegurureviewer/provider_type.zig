pub const ProviderType = enum {
    code_commit,
    git_hub,
    bitbucket,
    git_hub_enterprise_server,
    s3_bucket,

    pub const json_field_names = .{
        .code_commit = "CODE_COMMIT",
        .git_hub = "GIT_HUB",
        .bitbucket = "BITBUCKET",
        .git_hub_enterprise_server = "GIT_HUB_ENTERPRISE_SERVER",
        .s3_bucket = "S3_BUCKET",
    };
};
