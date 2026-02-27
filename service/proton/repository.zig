const RepositoryProvider = @import("repository_provider.zig").RepositoryProvider;

/// Detailed data of a linked repository—a repository that has been registered
/// with Proton.
pub const Repository = struct {
    /// The Amazon Resource Name (ARN) of the linked repository.
    arn: []const u8,

    /// The Amazon Resource Name (ARN) of your AWS CodeStar connection that connects
    /// Proton to your repository provider account.
    connection_arn: []const u8,

    /// Your customer Amazon Web Services KMS encryption key.
    encryption_key: ?[]const u8,

    /// The repository name.
    name: []const u8,

    /// The repository provider.
    provider: RepositoryProvider,

    pub const json_field_names = .{
        .arn = "arn",
        .connection_arn = "connectionArn",
        .encryption_key = "encryptionKey",
        .name = "name",
        .provider = "provider",
    };
};
