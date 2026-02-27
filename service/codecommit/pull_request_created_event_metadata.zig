/// Metadata about the pull request that is used when comparing the pull request
/// source with its destination.
pub const PullRequestCreatedEventMetadata = struct {
    /// The commit ID of the tip of the branch specified as the destination branch
    /// when the pull request was created.
    destination_commit_id: ?[]const u8,

    /// The commit ID of the most recent commit that the source branch and the
    /// destination branch have in common.
    merge_base: ?[]const u8,

    /// The name of the repository where the pull request was created.
    repository_name: ?[]const u8,

    /// The commit ID on the source branch used when the pull request was created.
    source_commit_id: ?[]const u8,

    pub const json_field_names = .{
        .destination_commit_id = "destinationCommitId",
        .merge_base = "mergeBase",
        .repository_name = "repositoryName",
        .source_commit_id = "sourceCommitId",
    };
};
