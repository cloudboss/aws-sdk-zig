/// The credentials for access to a private registry.
pub const AwsCodeBuildProjectEnvironmentRegistryCredential = struct {
    /// The ARN or name of credentials created using Secrets Manager.
    ///
    /// The credential can use the name of the credentials only if they exist in
    /// your current
    /// Amazon Web Services Region.
    credential: ?[]const u8,

    /// The service that created the credentials to access a private Docker
    /// registry.
    ///
    /// The valid value,` SECRETS_MANAGER`, is for Secrets Manager.
    credential_provider: ?[]const u8,

    pub const json_field_names = .{
        .credential = "Credential",
        .credential_provider = "CredentialProvider",
    };
};
