const RepositoryProvider = @import("repository_provider.zig").RepositoryProvider;

/// Detail data for a linked repository branch.
pub const RepositoryBranch = struct {
    /// The Amazon Resource Name (ARN) of the linked repository.
    arn: []const u8,

    /// The repository branch.
    branch: []const u8,

    /// The repository name.
    name: []const u8,

    /// The repository provider.
    provider: RepositoryProvider,

    pub const json_field_names = .{
        .arn = "arn",
        .branch = "branch",
        .name = "name",
        .provider = "provider",
    };
};
