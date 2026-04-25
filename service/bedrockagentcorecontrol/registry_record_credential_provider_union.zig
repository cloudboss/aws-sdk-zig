const RegistryRecordIamCredentialProvider = @import("registry_record_iam_credential_provider.zig").RegistryRecordIamCredentialProvider;
const RegistryRecordOAuthCredentialProvider = @import("registry_record_o_auth_credential_provider.zig").RegistryRecordOAuthCredentialProvider;

/// Union of supported credential provider types for registry record
/// synchronization.
pub const RegistryRecordCredentialProviderUnion = union(enum) {
    /// The IAM credential provider configuration for authenticating with the
    /// external source using SigV4 signing.
    iam_credential_provider: ?RegistryRecordIamCredentialProvider,
    /// The OAuth credential provider configuration for authenticating with the
    /// external source.
    oauth_credential_provider: ?RegistryRecordOAuthCredentialProvider,

    pub const json_field_names = .{
        .iam_credential_provider = "iamCredentialProvider",
        .oauth_credential_provider = "oauthCredentialProvider",
    };
};
