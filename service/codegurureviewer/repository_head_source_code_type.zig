/// A
/// [SourceCodeType](https://docs.aws.amazon.com/codeguru/latest/reviewer-api/API_SourceCodeType) that specifies the tip of a branch in an associated
/// repository.
pub const RepositoryHeadSourceCodeType = struct {
    /// The name of the branch in an associated repository. The
    /// `RepositoryHeadSourceCodeType` specifies the tip of this branch.
    branch_name: []const u8,

    pub const json_field_names = .{
        .branch_name = "BranchName",
    };
};
