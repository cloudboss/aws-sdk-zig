const CodeRepositoryProviderType = @import("code_repository_provider_type.zig").CodeRepositoryProviderType;

/// Contains details about a code repository associated with a finding.
pub const CodeRepositoryDetails = struct {
    /// The Amazon Resource Name (ARN) of the code security integration associated
    /// with the
    /// repository.
    integration_arn: ?[]const u8,

    /// The name of the project in the code repository.
    project_name: ?[]const u8,

    /// The type of repository provider (such as GitHub, GitLab, etc.).
    provider_type: ?CodeRepositoryProviderType,

    pub const json_field_names = .{
        .integration_arn = "integrationArn",
        .project_name = "projectName",
        .provider_type = "providerType",
    };
};
