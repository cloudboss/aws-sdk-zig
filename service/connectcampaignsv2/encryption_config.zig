const EncryptionType = @import("encryption_type.zig").EncryptionType;

/// Encryption config for Connect Instance. Note that sensitive data will always
/// be encrypted.
/// If disabled, service will perform encryption with its own key.
/// If enabled, a KMS key id needs to be provided and KMS charges will apply.
/// KMS is only type supported
pub const EncryptionConfig = struct {
    enabled: bool = false,

    encryption_type: ?EncryptionType = null,

    key_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .enabled = "enabled",
        .encryption_type = "encryptionType",
        .key_arn = "keyArn",
    };
};
