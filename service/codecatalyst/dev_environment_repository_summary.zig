/// Information about the source repsitory for a Dev Environment.
pub const DevEnvironmentRepositorySummary = struct {
    /// The name of the branch in a source repository cloned into the Dev
    /// Environment.
    branch_name: ?[]const u8 = null,

    /// The name of the source repository.
    repository_name: []const u8,

    pub const json_field_names = .{
        .branch_name = "branchName",
        .repository_name = "repositoryName",
    };
};
