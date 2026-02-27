pub const CodeRepositoryProviderType = enum {
    github,
    gitlab_self_managed,

    pub const json_field_names = .{
        .github = "GITHUB",
        .gitlab_self_managed = "GITLAB_SELF_MANAGED",
    };
};
