/// Information about a repository that will be cloned to a Dev Environment.
pub const RepositoryInput = struct {
    /// The name of the branch in a source repository.
    branch_name: ?[]const u8 = null,

    /// The name of the source repository.
    repository_name: []const u8,

    pub const json_field_names = .{
        .branch_name = "branchName",
        .repository_name = "repositoryName",
    };
};
