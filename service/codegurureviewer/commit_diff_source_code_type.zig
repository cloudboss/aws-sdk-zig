/// A type of
/// [SourceCodeType](https://docs.aws.amazon.com/codeguru/latest/reviewer-api/API_SourceCodeType) that
/// specifies the commit diff for a pull request on an associated repository.
/// The
/// `SourceCommit` and `DestinationCommit` fields are required to do a
/// pull request code review.
pub const CommitDiffSourceCodeType = struct {
    /// The SHA of the destination commit used to generate a commit diff. This field
    /// is required
    /// for a pull request code review.
    destination_commit: ?[]const u8,

    /// The SHA of the merge base of a commit.
    merge_base_commit: ?[]const u8,

    /// The SHA of the source commit used to generate a commit diff. This field is
    /// required for
    /// a pull request code review.
    source_commit: ?[]const u8,

    pub const json_field_names = .{
        .destination_commit = "DestinationCommit",
        .merge_base_commit = "MergeBaseCommit",
        .source_commit = "SourceCommit",
    };
};
