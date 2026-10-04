const EncryptionKeyType = @import("encryption_key_type.zig").EncryptionKeyType;

/// Specifies the key configuration for a user pool. Contains settings for
/// encryption keys used to secure user pool data.
pub const KeyConfigurationType = struct {
    /// The type of encryption key used for the user pool.
    ///
    /// **AWS_OWNED_KEY**
    ///
    /// A key owned by Amazon Web Services in Key Management Service.
    ///
    /// **CUSTOMER_MANAGED_KEY**
    ///
    /// A key managed by the customer in Key Management Service. You must use a
    /// multi-region key to enable multi-region
    /// replication for a user pool.
    key_type: ?EncryptionKeyType = null,

    /// The Amazon Resource Name (ARN) of the KMS key used for encryption. If not
    /// specified, Amazon Web Services managed keys are used.
    kms_key_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .key_type = "KeyType",
        .kms_key_arn = "KmsKeyArn",
    };
};
