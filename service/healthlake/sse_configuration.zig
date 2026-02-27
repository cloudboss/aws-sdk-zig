const KmsEncryptionConfig = @import("kms_encryption_config.zig").KmsEncryptionConfig;

/// The server-side encryption key configuration for a customer-provided
/// encryption
/// key.
pub const SseConfiguration = struct {
    /// The Key Management Service (KMS) encryption configuration used to provide
    /// details for data
    /// encryption.
    kms_encryption_config: KmsEncryptionConfig,

    pub const json_field_names = .{
        .kms_encryption_config = "KmsEncryptionConfig",
    };
};
