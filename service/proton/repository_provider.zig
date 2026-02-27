pub const RepositoryProvider = enum {
    github,
    github_enterprise,
    bitbucket,

    pub const json_field_names = .{
        .github = "GITHUB",
        .github_enterprise = "GITHUB_ENTERPRISE",
        .bitbucket = "BITBUCKET",
    };
};
