/// Information about a data provider.
pub const DataProviderDescriptorDefinition = struct {
    /// The name or Amazon Resource Name (ARN) of the data provider.
    data_provider_identifier: []const u8,

    /// The ARN of the role used to access Amazon Web Services Secrets Manager.
    secrets_manager_access_role_arn: ?[]const u8 = null,

    /// The identifier of the Amazon Web Services Secrets Manager Secret used to
    /// store access credentials for the data provider.
    secrets_manager_secret_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .data_provider_identifier = "DataProviderIdentifier",
        .secrets_manager_access_role_arn = "SecretsManagerAccessRoleArn",
        .secrets_manager_secret_id = "SecretsManagerSecretId",
    };
};
