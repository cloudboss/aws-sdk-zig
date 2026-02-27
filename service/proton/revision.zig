const RepositoryProvider = @import("repository_provider.zig").RepositoryProvider;

/// Revision detail data for a commit and push that activates a sync attempt
pub const Revision = struct {
    /// The repository branch.
    branch: []const u8,

    /// The repository directory changed by a commit and push that activated the
    /// sync attempt.
    directory: []const u8,

    /// The repository name.
    repository_name: []const u8,

    /// The repository provider.
    repository_provider: RepositoryProvider,

    /// The secure hash algorithm (SHA) hash for the revision.
    sha: []const u8,

    pub const json_field_names = .{
        .branch = "branch",
        .directory = "directory",
        .repository_name = "repositoryName",
        .repository_provider = "repositoryProvider",
        .sha = "sha",
    };
};
