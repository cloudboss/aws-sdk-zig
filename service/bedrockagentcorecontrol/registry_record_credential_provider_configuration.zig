const RegistryRecordCredentialProviderUnion = @import("registry_record_credential_provider_union.zig").RegistryRecordCredentialProviderUnion;
const RegistryRecordCredentialProviderType = @import("registry_record_credential_provider_type.zig").RegistryRecordCredentialProviderType;

/// A pairing of a credential provider type with its corresponding provider
/// details for authenticating with external sources.
pub const RegistryRecordCredentialProviderConfiguration = struct {
    /// The credential provider configuration details. The structure depends on the
    /// `credentialProviderType`.
    credential_provider: RegistryRecordCredentialProviderUnion,

    /// The type of credential provider.
    ///
    /// * `OAUTH` - OAuth-based authentication.
    /// * `IAM` - Amazon Web Services IAM-based authentication using SigV4 signing.
    credential_provider_type: RegistryRecordCredentialProviderType,

    pub const json_field_names = .{
        .credential_provider = "credentialProvider",
        .credential_provider_type = "credentialProviderType",
    };
};
