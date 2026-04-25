const RegistryRecordCredentialProviderConfiguration = @import("registry_record_credential_provider_configuration.zig").RegistryRecordCredentialProviderConfiguration;

/// Configuration for synchronizing from a URL-based MCP server.
pub const FromUrlSynchronizationConfiguration = struct {
    /// Optional list of credential provider configurations for authenticating with
    /// the MCP server. At most one credential provider configuration can be
    /// specified.
    credential_provider_configurations: ?[]const RegistryRecordCredentialProviderConfiguration = null,

    /// The HTTPS URL of the MCP server to synchronize from.
    url: []const u8,

    pub const json_field_names = .{
        .credential_provider_configurations = "credentialProviderConfigurations",
        .url = "url",
    };
};
