pub const IntegrationType = enum {
    gitlab_self_managed,
    github,

    pub const json_field_names = .{
        .gitlab_self_managed = "GITLAB_SELF_MANAGED",
        .github = "GITHUB",
    };
};
