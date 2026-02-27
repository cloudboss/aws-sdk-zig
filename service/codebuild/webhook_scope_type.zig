pub const WebhookScopeType = enum {
    github_organization,
    github_global,
    gitlab_group,

    pub const json_field_names = .{
        .github_organization = "GITHUB_ORGANIZATION",
        .github_global = "GITHUB_GLOBAL",
        .gitlab_group = "GITLAB_GROUP",
    };
};
