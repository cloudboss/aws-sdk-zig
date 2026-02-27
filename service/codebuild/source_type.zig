pub const SourceType = enum {
    codecommit,
    codepipeline,
    github,
    gitlab,
    gitlab_self_managed,
    s3,
    bitbucket,
    github_enterprise,
    no_source,

    pub const json_field_names = .{
        .codecommit = "CODECOMMIT",
        .codepipeline = "CODEPIPELINE",
        .github = "GITHUB",
        .gitlab = "GITLAB",
        .gitlab_self_managed = "GITLAB_SELF_MANAGED",
        .s3 = "S3",
        .bitbucket = "BITBUCKET",
        .github_enterprise = "GITHUB_ENTERPRISE",
        .no_source = "NO_SOURCE",
    };
};
