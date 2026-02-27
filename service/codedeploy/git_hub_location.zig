/// Information about the location of application artifacts stored in GitHub.
pub const GitHubLocation = struct {
    /// The SHA1 commit ID of the GitHub commit that represents the bundled
    /// artifacts for the
    /// application revision.
    commit_id: ?[]const u8,

    /// The GitHub account and repository pair that stores a reference to the commit
    /// that
    /// represents the bundled artifacts for the application revision.
    ///
    /// Specified as account/repository.
    repository: ?[]const u8,

    pub const json_field_names = .{
        .commit_id = "commitId",
        .repository = "repository",
    };
};
