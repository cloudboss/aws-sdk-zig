const RegistryRecordCredentialProviderUnion = @import("registry_record_credential_provider_union.zig").RegistryRecordCredentialProviderUnion;
const RegistryRecordCredentialProviderType = @import("registry_record_credential_provider_type.zig").RegistryRecordCredentialProviderType;

/// A credential provider configuration that specifies how to authenticate when
/// fetching descriptor content from a registry record's source URL.
pub const RegistryRecordCredentialProviderConfiguration = struct {
    /// The credential provider details corresponding to the specified credential
    /// provider type.
    credential_provider: RegistryRecordCredentialProviderUnion,

    /// The type of credential provider.
    credential_provider_type: RegistryRecordCredentialProviderType,

    pub const json_field_names = .{
        .credential_provider = "credentialProvider",
        .credential_provider_type = "credentialProviderType",
    };
};
