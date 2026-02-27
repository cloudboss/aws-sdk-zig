const SecretsManagerEncryptionKeyConfiguration = @import("secrets_manager_encryption_key_configuration.zig").SecretsManagerEncryptionKeyConfiguration;

/// Contains the configuration settings for decrypting SRT streams, including
/// the encryption key details and decryption parameters.
pub const SrtDecryptionConfiguration = struct {
    /// Specifies the encryption key configuration used for decrypting SRT streams,
    /// including the key source and associated credentials.
    encryption_key: SecretsManagerEncryptionKeyConfiguration,

    pub const json_field_names = .{
        .encryption_key = "EncryptionKey",
    };
};
