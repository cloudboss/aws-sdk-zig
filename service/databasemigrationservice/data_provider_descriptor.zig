/// Information about a data provider.
pub const DataProviderDescriptor = struct {
    /// The Amazon Resource Name (ARN) of the data provider.
    data_provider_arn: ?[]const u8,

    /// The user-friendly name of the data provider.
    data_provider_name: ?[]const u8,

    /// The ARN of the role used to access Amazon Web Services Secrets Manager.
    secrets_manager_access_role_arn: ?[]const u8,

    /// The identifier of the Amazon Web Services Secrets Manager Secret used to
    /// store access credentials for the data provider.
    secrets_manager_secret_id: ?[]const u8,

    pub const json_field_names = .{
        .data_provider_arn = "DataProviderArn",
        .data_provider_name = "DataProviderName",
        .secrets_manager_access_role_arn = "SecretsManagerAccessRoleArn",
        .secrets_manager_secret_id = "SecretsManagerSecretId",
    };
};
