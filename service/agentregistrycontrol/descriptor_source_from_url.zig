const RegistryRecordCredentialProviderConfiguration = @import("registry_record_credential_provider_configuration.zig").RegistryRecordCredentialProviderConfiguration;

/// URL-based descriptor source configuration, with credential provider
/// configurations for authenticated URL retrieval.
pub const DescriptorSourceFromUrl = struct {
    /// The credential providers used to authenticate when fetching descriptor
    /// content from the source URL.
    credential_provider_configurations: ?[]const RegistryRecordCredentialProviderConfiguration = null,

    /// The URL from which the descriptor content is retrieved.
    url: []const u8,

    pub const json_field_names = .{
        .credential_provider_configurations = "credentialProviderConfigurations",
        .url = "url",
    };
};
