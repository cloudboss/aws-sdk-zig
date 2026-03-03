const KMSEncryptionConfig = @import("kms_encryption_config.zig").KMSEncryptionConfig;
const NoEncryptionConfig = @import("no_encryption_config.zig").NoEncryptionConfig;

/// Describes the encryption for a destination in Amazon S3.
pub const EncryptionConfiguration = struct {
    /// The encryption key.
    kms_encryption_config: ?KMSEncryptionConfig = null,

    /// Specifically override existing encryption information to ensure that no
    /// encryption is
    /// used.
    no_encryption_config: ?NoEncryptionConfig = null,

    pub const json_field_names = .{
        .kms_encryption_config = "KMSEncryptionConfig",
        .no_encryption_config = "NoEncryptionConfig",
    };
};
