const MergeMetadata = @import("merge_metadata.zig").MergeMetadata;

/// Returns information about a pull request target.
pub const PullRequestTarget = struct {
    /// The full commit ID that is the tip of the destination branch. This is the
    /// commit where the pull request was or will be merged.
    destination_commit: ?[]const u8 = null,

    /// The branch of the repository where the pull request changes are merged. Also
    /// known as
    /// the destination branch.
    destination_reference: ?[]const u8 = null,

    /// The commit ID of the most recent commit that the source branch and the
    /// destination branch have in common.
    merge_base: ?[]const u8 = null,

    /// Returns metadata about the state of the merge, including whether the merge
    /// has been made.
    merge_metadata: ?MergeMetadata = null,

    /// The name of the repository that contains the pull request source and
    /// destination branches.
    repository_name: ?[]const u8 = null,

    /// The full commit ID of the tip of the source branch used to create the pull
    /// request. If
    /// the pull request branch is updated by a push while the pull request is open,
    /// the commit
    /// ID changes to reflect the new tip of the branch.
    source_commit: ?[]const u8 = null,

    /// The branch of the repository that contains the changes for the pull request.
    /// Also known as the source branch.
    source_reference: ?[]const u8 = null,

    pub const json_field_names = .{
        .destination_commit = "destinationCommit",
        .destination_reference = "destinationReference",
        .merge_base = "mergeBase",
        .merge_metadata = "mergeMetadata",
        .repository_name = "repositoryName",
        .source_commit = "sourceCommit",
        .source_reference = "sourceReference",
    };
};
