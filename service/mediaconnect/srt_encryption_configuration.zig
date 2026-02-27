const SecretsManagerEncryptionKeyConfiguration = @import("secrets_manager_encryption_key_configuration.zig").SecretsManagerEncryptionKeyConfiguration;

/// Contains the configuration settings for encrypting SRT streams, including
/// the encryption key details and encryption parameters.
pub const SrtEncryptionConfiguration = struct {
    /// Specifies the encryption key configuration used for encrypting SRT streams,
    /// including the key source and associated credentials.
    encryption_key: SecretsManagerEncryptionKeyConfiguration,

    pub const json_field_names = .{
        .encryption_key = "EncryptionKey",
    };
};
