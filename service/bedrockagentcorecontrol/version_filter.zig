/// A filter for listing configuration bundle versions.
pub const VersionFilter = struct {
    /// Filter by branch name.
    branch_name: ?[]const u8 = null,

    /// Filter by creation source name.
    created_by_name: ?[]const u8 = null,

    /// When true, returns only the latest version for each branch. When false or
    /// not specified, returns all versions. Can be combined with `branchName` to
    /// get the latest version for a specific branch.
    latest_per_branch: ?bool = null,

    pub const json_field_names = .{
        .branch_name = "branchName",
        .created_by_name = "createdByName",
        .latest_per_branch = "latestPerBranch",
    };
};
