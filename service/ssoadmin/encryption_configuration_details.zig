const KmsKeyStatus = @import("kms_key_status.zig").KmsKeyStatus;
const KmsKeyType = @import("kms_key_type.zig").KmsKeyType;

/// The encryption configuration of your IAM Identity Center instance, including
/// the key type, KMS key ARN, and current encryption status.
pub const EncryptionConfigurationDetails = struct {
    /// The current status of encryption configuration.
    encryption_status: ?KmsKeyStatus = null,

    /// Provides additional context about the current encryption status. This field
    /// is particularly useful when the encryption status is UPDATE_FAILED. When
    /// encryption configuration update fails, this field contains information about
    /// the cause, which may include KMS key access issues, key not found errors,
    /// invalid key configuration, key in an invalid state, or a disabled key.
    encryption_status_reason: ?[]const u8 = null,

    /// The type of KMS key used for encryption.
    key_type: ?KmsKeyType = null,

    /// The ARN of the KMS key currently used to encrypt data in your IAM Identity
    /// Center instance.
    kms_key_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .encryption_status = "EncryptionStatus",
        .encryption_status_reason = "EncryptionStatusReason",
        .key_type = "KeyType",
        .kms_key_arn = "KmsKeyArn",
    };
};
