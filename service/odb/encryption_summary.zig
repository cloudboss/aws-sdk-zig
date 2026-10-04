const EncryptionKeyConfiguration = @import("encryption_key_configuration.zig").EncryptionKeyConfiguration;
const EncryptionKeyProvider = @import("encryption_key_provider.zig").EncryptionKeyProvider;

/// The encryption configuration for an Autonomous Database.
pub const EncryptionSummary = struct {
    /// The configuration of the encryption key used for the Autonomous Database.
    encryption_key_configuration: ?EncryptionKeyConfiguration = null,

    /// The provider of the encryption key used for the Autonomous Database.
    encryption_key_provider: ?EncryptionKeyProvider = null,

    pub const json_field_names = .{
        .encryption_key_configuration = "encryptionKeyConfiguration",
        .encryption_key_provider = "encryptionKeyProvider",
    };
};
