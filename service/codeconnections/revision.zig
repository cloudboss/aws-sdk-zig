const ProviderType = @import("provider_type.zig").ProviderType;

/// Information about the revision for a specific sync event, such as the
/// branch, owner ID, and name of the repository.
pub const Revision = struct {
    /// The branch name for a specific revision.
    branch: []const u8,

    /// The directory, if any, for a specific revision.
    directory: []const u8,

    /// The owner ID for a specific revision, such as the GitHub owner ID for a
    /// GitHub repository.
    owner_id: []const u8,

    /// The provider type for a revision, such as GitHub.
    provider_type: ProviderType,

    /// The repository name for a specific revision.
    repository_name: []const u8,

    /// The SHA, such as the commit ID, for a specific revision.
    sha: []const u8,

    pub const json_field_names = .{
        .branch = "Branch",
        .directory = "Directory",
        .owner_id = "OwnerId",
        .provider_type = "ProviderType",
        .repository_name = "RepositoryName",
        .sha = "Sha",
    };
};
