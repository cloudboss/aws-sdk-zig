/// Information about a repository name and ID.
pub const RepositoryNameIdPair = struct {
    /// The ID associated with the repository.
    repository_id: ?[]const u8 = null,

    /// The name associated with the repository.
    repository_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .repository_id = "repositoryId",
        .repository_name = "repositoryName",
    };
};
