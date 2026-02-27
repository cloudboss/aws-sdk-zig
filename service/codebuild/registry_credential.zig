const CredentialProviderType = @import("credential_provider_type.zig").CredentialProviderType;

/// Information about credentials that provide access to a private Docker
/// registry. When
/// this is set:
///
/// * `imagePullCredentialsType` must be set to `SERVICE_ROLE`.
///
/// * images cannot be curated or an Amazon ECR image.
///
/// For more information, see [Private Registry with
/// Secrets Manager Sample for
/// CodeBuild](https://docs.aws.amazon.com/codebuild/latest/userguide/sample-private-registry.html).
pub const RegistryCredential = struct {
    /// The Amazon Resource Name (ARN) or name of credentials created using Secrets
    /// Manager.
    ///
    /// The `credential` can use the name of the credentials only if they
    /// exist in your current Amazon Web Services Region.
    credential: []const u8,

    /// The service that created the credentials to access a private Docker
    /// registry. The
    /// valid value, SECRETS_MANAGER, is for Secrets Manager.
    credential_provider: CredentialProviderType,

    pub const json_field_names = .{
        .credential = "credential",
        .credential_provider = "credentialProvider",
    };
};
