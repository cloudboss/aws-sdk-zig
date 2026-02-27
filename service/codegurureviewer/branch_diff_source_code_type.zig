/// A type of
/// [SourceCodeType](https://docs.aws.amazon.com/codeguru/latest/reviewer-api/API_SourceCodeType) that
/// specifies a code diff between a source and destination branch in an
/// associated
/// repository.
pub const BranchDiffSourceCodeType = struct {
    /// The destination branch for a diff in an associated repository.
    destination_branch_name: []const u8,

    /// The source branch for a diff in an associated repository.
    source_branch_name: []const u8,

    pub const json_field_names = .{
        .destination_branch_name = "DestinationBranchName",
        .source_branch_name = "SourceBranchName",
    };
};
