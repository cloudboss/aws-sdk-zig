const CredentialProvider = @import("credential_provider.zig").CredentialProvider;
const CredentialProviderType = @import("credential_provider_type.zig").CredentialProviderType;

/// The configuration for a credential provider. This structure defines how the
/// gateway authenticates with the target endpoint.
pub const CredentialProviderConfiguration = struct {
    /// The credential provider. This field contains the specific configuration for
    /// the credential provider type.
    credential_provider: ?CredentialProvider = null,

    /// The type of credential provider. This field specifies which authentication
    /// method the gateway uses.
    credential_provider_type: CredentialProviderType,

    pub const json_field_names = .{
        .credential_provider = "credentialProvider",
        .credential_provider_type = "credentialProviderType",
    };
};
