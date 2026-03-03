const SourceReference = @import("source_reference.zig").SourceReference;

/// Contains detailed information about the source code repository that hosts
/// the workflow definition files.
pub const DefinitionRepositoryDetails = struct {
    /// The Amazon Resource Name (ARN) of the connection to the source code
    /// repository.
    connection_arn: ?[]const u8 = null,

    /// The full repository identifier, including the repository owner and name. For
    /// example, 'repository-owner/repository-name'.
    full_repository_id: ?[]const u8 = null,

    /// The endpoint URL of the source code repository provider.
    provider_endpoint: ?[]const u8 = null,

    /// The provider type of the source code repository, such as Bitbucket, GitHub,
    /// GitHubEnterpriseServer, GitLab, and GitLabSelfManaged.
    provider_type: ?[]const u8 = null,

    /// The source reference for the repository, such as a branch name, tag, or
    /// commit ID.
    source_reference: ?SourceReference = null,

    pub const json_field_names = .{
        .connection_arn = "connectionArn",
        .full_repository_id = "fullRepositoryId",
        .provider_endpoint = "providerEndpoint",
        .provider_type = "providerType",
        .source_reference = "sourceReference",
    };
};
