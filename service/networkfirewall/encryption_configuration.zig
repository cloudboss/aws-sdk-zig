const EncryptionType = @import("encryption_type.zig").EncryptionType;

/// A complex type that contains optional Amazon Web Services Key Management
/// Service (KMS) encryption settings for your Network Firewall resources. Your
/// data is encrypted by default with an Amazon Web Services owned key that
/// Amazon Web Services owns and manages for you. You can use either the Amazon
/// Web Services owned key, or provide your own customer managed key. To learn
/// more about KMS encryption of your Network Firewall resources, see
/// [Encryption at rest with Amazon Web Services Key Managment
/// Service](https://docs.aws.amazon.com/kms/latest/developerguide/kms-encryption-at-rest.html) in the *Network Firewall Developer Guide*.
pub const EncryptionConfiguration = struct {
    /// The ID of the Amazon Web Services Key Management Service (KMS) customer
    /// managed key. You can use any of the key identifiers that KMS supports,
    /// unless you're using a key that's managed by another account. If you're using
    /// a key managed by another account, then specify the key ARN. For more
    /// information, see [Key
    /// ID](https://docs.aws.amazon.com/kms/latest/developerguide/concepts.html#key-id) in the *Amazon Web Services KMS Developer Guide*.
    key_id: ?[]const u8 = null,

    /// The type of Amazon Web Services KMS key to use for encryption of your
    /// Network Firewall resources.
    @"type": EncryptionType,

    pub const json_field_names = .{
        .key_id = "KeyId",
        .@"type" = "Type",
    };
};
