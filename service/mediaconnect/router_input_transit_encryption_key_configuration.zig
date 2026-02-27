const AutomaticEncryptionKeyConfiguration = @import("automatic_encryption_key_configuration.zig").AutomaticEncryptionKeyConfiguration;
const SecretsManagerEncryptionKeyConfiguration = @import("secrets_manager_encryption_key_configuration.zig").SecretsManagerEncryptionKeyConfiguration;

/// Defines the configuration settings for transit encryption keys.
pub const RouterInputTransitEncryptionKeyConfiguration = union(enum) {
    automatic: ?AutomaticEncryptionKeyConfiguration,
    secrets_manager: ?SecretsManagerEncryptionKeyConfiguration,

    pub const json_field_names = .{
        .automatic = "Automatic",
        .secrets_manager = "SecretsManager",
    };
};
