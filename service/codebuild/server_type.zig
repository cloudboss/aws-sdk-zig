pub const ServerType = enum {
    github,
    bitbucket,
    github_enterprise,
    gitlab,
    gitlab_self_managed,

    pub const json_field_names = .{
        .github = "GITHUB",
        .bitbucket = "BITBUCKET",
        .github_enterprise = "GITHUB_ENTERPRISE",
        .gitlab = "GITLAB",
        .gitlab_self_managed = "GITLAB_SELF_MANAGED",
    };
};
