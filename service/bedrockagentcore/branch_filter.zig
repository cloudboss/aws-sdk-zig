/// Contains filter criteria for branches when listing events.
pub const BranchFilter = struct {
    /// Specifies whether to include parent branches in the results. Set to true to
    /// include parent branches, or false to exclude them.
    include_parent_branches: bool = true,

    /// The name of the branch to filter by.
    name: []const u8,

    pub const json_field_names = .{
        .include_parent_branches = "includeParentBranches",
        .name = "name",
    };
};
