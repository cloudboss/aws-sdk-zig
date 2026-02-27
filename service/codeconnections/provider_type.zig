pub const ProviderType = enum {
    bitbucket,
    github,
    github_enterprise_server,
    gitlab,
    gitlab_self_managed,
    azure_dev_ops,

    pub const json_field_names = .{
        .bitbucket = "BITBUCKET",
        .github = "GITHUB",
        .github_enterprise_server = "GITHUB_ENTERPRISE_SERVER",
        .gitlab = "GITLAB",
        .gitlab_self_managed = "GITLAB_SELF_MANAGED",
        .azure_dev_ops = "AZURE_DEV_OPS",
    };
};
