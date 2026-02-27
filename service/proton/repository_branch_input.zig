const RepositoryProvider = @import("repository_provider.zig").RepositoryProvider;

/// Detail input data for a linked repository branch.
pub const RepositoryBranchInput = struct {
    /// The repository branch.
    branch: []const u8,

    /// The repository name.
    name: []const u8,

    /// The repository provider.
    provider: RepositoryProvider,

    pub const json_field_names = .{
        .branch = "branch",
        .name = "name",
        .provider = "provider",
    };
};
