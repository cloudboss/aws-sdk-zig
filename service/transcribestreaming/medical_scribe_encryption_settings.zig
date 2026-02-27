const aws = @import("aws");

/// Contains encryption related settings to be used for data encryption with Key
/// Management Service, including KmsEncryptionContext and KmsKeyId.
/// The KmsKeyId is required, while KmsEncryptionContext is optional for
/// additional layer of security.
///
/// By default, Amazon Web Services HealthScribe provides encryption at rest to
/// protect sensitive customer data using Amazon S3-managed keys. HealthScribe
/// uses the KMS key you specify as a second layer of
/// encryption.
///
/// Your `ResourceAccessRoleArn`
/// must permission to use your KMS key.
/// For more information, see [Data Encryption at rest for Amazon Web Services
/// HealthScribe](https://docs.aws.amazon.com/transcribe/latest/dg/health-scribe-encryption.html).
pub const MedicalScribeEncryptionSettings = struct {
    /// A map of plain text, non-secret key:value pairs, known as encryption context
    /// pairs, that provide an added layer of
    /// security for your data. For more information, see [KMSencryption context
    /// ](https://docs.aws.amazon.com/transcribe/latest/dg/key-management.html#kms-context) and [Asymmetric keys in KMS
    /// ](https://docs.aws.amazon.com/transcribe/latest/dg/symmetric-asymmetric.html).
    kms_encryption_context: ?[]const aws.map.StringMapEntry,

    /// The ID of the KMS key you want to use for your streaming session. You
    /// can specify its KMS key ID, key Amazon Resource Name (ARN), alias name, or
    /// alias ARN. When using an alias name, prefix it with `"alias/"`.
    /// To specify a KMS key in a different Amazon Web Services account, you must
    /// use the key ARN or alias ARN.
    ///
    /// For example:
    ///
    /// * Key ID: 1234abcd-12ab-34cd-56ef-1234567890ab
    ///
    /// * Key ARN:
    ///   arn:aws:kms:us-east-2:111122223333:key/1234abcd-12ab-34cd-56ef-1234567890ab
    ///
    /// * Alias name: alias/ExampleAlias
    ///
    /// * Alias ARN: arn:aws:kms:us-east-2:111122223333:alias/ExampleAlias
    ///
    /// To get the key ID and key ARN for a KMS key, use the
    /// [ListKeys](https://docs.aws.amazon.com/kms/latest/APIReference/API_ListKeys.html) or [DescribeKey](https://docs.aws.amazon.com/kms/latest/APIReference/API_DescribeKey.html) KMS API operations.
    /// To get the alias name and alias ARN, use
    /// [ListKeys](https://docs.aws.amazon.com/kms/latest/APIReference/API_ListAliases.html) API operation.
    kms_key_id: []const u8,

    pub const json_field_names = .{
        .kms_encryption_context = "KmsEncryptionContext",
        .kms_key_id = "KmsKeyId",
    };
};
