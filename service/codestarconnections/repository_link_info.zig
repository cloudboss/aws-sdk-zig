const ProviderType = @import("provider_type.zig").ProviderType;

/// Information about the repository link resource, such as the repository link
/// ARN, the associated connection ARN, encryption key ARN, and owner ID.
pub const RepositoryLinkInfo = struct {
    /// The Amazon Resource Name (ARN) of the connection associated with the
    /// repository link.
    connection_arn: []const u8,

    /// The Amazon Resource Name (ARN) of the encryption key for the repository
    /// associated with the repository link.
    encryption_key_arn: ?[]const u8 = null,

    /// The owner ID for the repository associated with the repository link, such as
    /// the owner
    /// ID in GitHub.
    owner_id: []const u8,

    /// The provider type for the connection, such as GitHub, associated with the
    /// repository link.
    provider_type: ProviderType,

    /// The Amazon Resource Name (ARN) of the repository link.
    repository_link_arn: []const u8,

    /// The ID of the repository link.
    repository_link_id: []const u8,

    /// The name of the repository associated with the repository link.
    repository_name: []const u8,

    pub const json_field_names = .{
        .connection_arn = "ConnectionArn",
        .encryption_key_arn = "EncryptionKeyArn",
        .owner_id = "OwnerId",
        .provider_type = "ProviderType",
        .repository_link_arn = "RepositoryLinkArn",
        .repository_link_id = "RepositoryLinkId",
        .repository_name = "RepositoryName",
    };
};
