const EncryptionType = @import("encryption_type.zig").EncryptionType;

/// Encryption context for a Domain.
pub const EncryptionContext = struct {
    /// The type of encryption key used.
    encryption_type: EncryptionType,

    /// The ARN of the KMS key. Only present when encryptionType is
    /// CUSTOMER_MANAGED_KEY.
    kms_key_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .encryption_type = "encryptionType",
        .kms_key_arn = "kmsKeyArn",
    };
};
