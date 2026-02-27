/// Contains information about an API key credential provider.
pub const ApiKeyCredentialProviderItem = struct {
    /// The timestamp when the API key credential provider was created.
    created_time: i64,

    /// The Amazon Resource Name (ARN) of the API key credential provider.
    credential_provider_arn: []const u8,

    /// The timestamp when the API key credential provider was last updated.
    last_updated_time: i64,

    /// The name of the API key credential provider.
    name: []const u8,

    pub const json_field_names = .{
        .created_time = "createdTime",
        .credential_provider_arn = "credentialProviderArn",
        .last_updated_time = "lastUpdatedTime",
        .name = "name",
    };
};
