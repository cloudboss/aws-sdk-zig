const KmsKeyType = @import("kms_key_type.zig").KmsKeyType;

/// A structure that specifies the KMS key type and KMS key ARN used to encrypt
/// data in your IAM Identity Center instance.
pub const EncryptionConfiguration = struct {
    /// The type of KMS key used for encryption.
    key_type: KmsKeyType,

    /// The ARN of the KMS key used to encrypt data. Required when KeyType is
    /// CUSTOMER_MANAGED_KEY. Cannot be specified when KeyType is AWS_OWNED_KMS_KEY.
    kms_key_arn: ?[]const u8,

    pub const json_field_names = .{
        .key_type = "KeyType",
        .kms_key_arn = "KmsKeyArn",
    };
};
