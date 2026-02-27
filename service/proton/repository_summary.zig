const RepositoryProvider = @import("repository_provider.zig").RepositoryProvider;

/// Summary data of a linked repository—a repository that has been registered
/// with Proton.
pub const RepositorySummary = struct {
    /// The Amazon Resource Name (ARN) of the linked repository.
    arn: []const u8,

    /// The Amazon Resource Name (ARN) of the of your connection that connects
    /// Proton to your repository.
    connection_arn: []const u8,

    /// The repository name.
    name: []const u8,

    /// The repository provider.
    provider: RepositoryProvider,

    pub const json_field_names = .{
        .arn = "arn",
        .connection_arn = "connectionArn",
        .name = "name",
        .provider = "provider",
    };
};
