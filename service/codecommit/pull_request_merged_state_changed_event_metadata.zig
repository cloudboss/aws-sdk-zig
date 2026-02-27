const MergeMetadata = @import("merge_metadata.zig").MergeMetadata;

/// Returns information about the change in the merge state for a pull request
/// event.
pub const PullRequestMergedStateChangedEventMetadata = struct {
    /// The name of the branch that the pull request is merged into.
    destination_reference: ?[]const u8,

    /// Information about the merge state change event.
    merge_metadata: ?MergeMetadata,

    /// The name of the repository where the pull request was created.
    repository_name: ?[]const u8,

    pub const json_field_names = .{
        .destination_reference = "destinationReference",
        .merge_metadata = "mergeMetadata",
        .repository_name = "repositoryName",
    };
};
