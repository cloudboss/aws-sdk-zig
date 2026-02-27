/// Information about an update to the source branch of a pull request.
pub const PullRequestSourceReferenceUpdatedEventMetadata = struct {
    /// The full commit ID of the commit in the source branch that was the tip of
    /// the branch at the time the pull request was updated.
    after_commit_id: ?[]const u8,

    /// The full commit ID of the commit in the destination branch that was the tip
    /// of the branch at the time the pull request was updated.
    before_commit_id: ?[]const u8,

    /// The commit ID of the most recent commit that the source branch and the
    /// destination branch have in common.
    merge_base: ?[]const u8,

    /// The name of the repository where the pull request was updated.
    repository_name: ?[]const u8,

    pub const json_field_names = .{
        .after_commit_id = "afterCommitId",
        .before_commit_id = "beforeCommitId",
        .merge_base = "mergeBase",
        .repository_name = "repositoryName",
    };
};
