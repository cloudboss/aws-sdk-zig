/// Contains details about a code remediation task, including links to the code
/// diff and pull request.
pub const CodeRemediationTaskDetails = struct {
    /// The link to the code diff for the remediation.
    code_diff_link: ?[]const u8 = null,

    /// The link to the pull request created for the remediation.
    pull_request_link: ?[]const u8 = null,

    /// The name of the repository where the remediation was applied.
    repo_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .code_diff_link = "codeDiffLink",
        .pull_request_link = "pullRequestLink",
        .repo_name = "repoName",
    };
};
