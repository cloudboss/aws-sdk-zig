const RegistryRecordIamCredentialProvider = @import("registry_record_iam_credential_provider.zig").RegistryRecordIamCredentialProvider;
const RegistryRecordOAuthCredentialProvider = @import("registry_record_o_auth_credential_provider.zig").RegistryRecordOAuthCredentialProvider;

/// The credential provider details for a registry record. Exactly one member is
/// populated, matching the configured credential provider type.
pub const RegistryRecordCredentialProviderUnion = union(enum) {
    /// The IAM role credential provider details.
    iam_credential_provider: ?RegistryRecordIamCredentialProvider,
    /// The OAuth 2.0 credential provider details.
    oauth_credential_provider: ?RegistryRecordOAuthCredentialProvider,

    pub const json_field_names = .{
        .iam_credential_provider = "iamCredentialProvider",
        .oauth_credential_provider = "oauthCredentialProvider",
    };
};
