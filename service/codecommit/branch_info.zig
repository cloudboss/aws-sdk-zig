/// Returns information about a branch.
pub const BranchInfo = struct {
    /// The name of the branch.
    branch_name: ?[]const u8 = null,

    /// The ID of the last commit made to the branch.
    commit_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .branch_name = "branchName",
        .commit_id = "commitId",
    };
};
