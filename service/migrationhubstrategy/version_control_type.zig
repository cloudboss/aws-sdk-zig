pub const VersionControlType = enum {
    github,
    github_enterprise,
    azure_devops_git,

    pub const json_field_names = .{
        .github = "GITHUB",
        .github_enterprise = "GITHUB_ENTERPRISE",
        .azure_devops_git = "AZURE_DEVOPS_GIT",
    };
};
