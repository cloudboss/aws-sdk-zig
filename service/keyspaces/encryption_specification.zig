const EncryptionType = @import("encryption_type.zig").EncryptionType;

/// Amazon Keyspaces encrypts and decrypts the table data at rest transparently
/// and integrates with Key Management Service for storing and managing the
/// encryption key. You can choose one of the following KMS keys (KMS keys):
///
/// * Amazon Web Services owned key - This is the default encryption type. The
///   key is owned by Amazon Keyspaces (no additional charge).
/// * Customer managed key - This key is stored in your account and is created,
///   owned, and managed by you. You have full control over the customer managed
///   key (KMS charges apply).
///
/// For more information about encryption at rest in Amazon Keyspaces, see
/// [Encryption at
/// rest](https://docs.aws.amazon.com/keyspaces/latest/devguide/EncryptionAtRest.html) in the *Amazon Keyspaces Developer Guide*.
///
/// For more information about KMS, see [KMS management service
/// concepts](https://docs.aws.amazon.com/keyspaces/latest/devguide/EncryptionAtRest.html) in the *Key Management Service Developer Guide*.
pub const EncryptionSpecification = struct {
    /// The Amazon Resource Name (ARN) of the customer managed KMS key, for example
    /// `kms_key_identifier:ARN`.
    kms_key_identifier: ?[]const u8,

    /// The encryption option specified for the table. You can choose one of the
    /// following KMS keys (KMS keys):
    ///
    /// * `type:AWS_OWNED_KMS_KEY` - This key is owned by Amazon Keyspaces.
    /// * `type:CUSTOMER_MANAGED_KMS_KEY` - This key is stored in your account and
    ///   is created, owned, and managed by you. This option requires the
    ///   `kms_key_identifier` of the KMS key in Amazon Resource Name (ARN) format
    ///   as input.
    ///
    /// The default is `type:AWS_OWNED_KMS_KEY`.
    ///
    /// For more information, see [Encryption at
    /// rest](https://docs.aws.amazon.com/keyspaces/latest/devguide/EncryptionAtRest.html) in the *Amazon Keyspaces Developer Guide*.
    @"type": EncryptionType,

    pub const json_field_names = .{
        .kms_key_identifier = "kmsKeyIdentifier",
        .@"type" = "type",
    };
};
