const SecretsManagerCredentialsProvider = @import("secrets_manager_credentials_provider.zig").SecretsManagerCredentialsProvider;

/// Contains information about the credential provider for user administration.
pub const CredentialsProvider = union(enum) {
    /// Identifies the Secrets Manager secret that contains credentials needed for
    /// user administration in the Active Directory.
    secrets_manager_credentials_provider: ?SecretsManagerCredentialsProvider,

    pub const json_field_names = .{
        .secrets_manager_credentials_provider = "SecretsManagerCredentialsProvider",
    };
};
