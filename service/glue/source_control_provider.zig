pub const SourceControlProvider = enum {
    github,
    gitlab,
    bitbucket,
    aws_code_commit,

    pub const json_field_names = .{
        .github = "GITHUB",
        .gitlab = "GITLAB",
        .bitbucket = "BITBUCKET",
        .aws_code_commit = "AWS_CODE_COMMIT",
    };
};
