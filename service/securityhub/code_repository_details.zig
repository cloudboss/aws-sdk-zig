/// Details about an external code repository with which you can connect your
/// Amazon Web Services resources.
/// The connection is established through Amazon Inspector.
pub const CodeRepositoryDetails = struct {
    /// The Amazon Resource Name (ARN) of the code security integration associated
    /// with the repository.
    code_security_integration_arn: ?[]const u8,

    /// The name of the project in the code repository.
    project_name: ?[]const u8,

    /// The type of repository provider.
    provider_type: ?[]const u8,

    pub const json_field_names = .{
        .code_security_integration_arn = "CodeSecurityIntegrationArn",
        .project_name = "ProjectName",
        .provider_type = "ProviderType",
    };
};
