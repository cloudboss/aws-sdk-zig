const EncryptionType = @import("encryption_type.zig").EncryptionType;

/// The encryption configuration to associate with the repository creation
/// template.
pub const EncryptionConfigurationForRepositoryCreationTemplate = struct {
    /// The encryption type to use.
    ///
    /// If you use the `KMS` encryption type, the contents of the repository will
    /// be encrypted using server-side encryption with Key Management Service key
    /// stored in KMS. When you
    /// use KMS to encrypt your data, you can either use the default Amazon Web
    /// Services managed KMS key
    /// for Amazon ECR, or specify your own KMS key, which you already created. For
    /// more
    /// information, see [Protecting data using server-side
    /// encryption with an KMS key stored in Key Management Service
    /// (SSE-KMS)](https://docs.aws.amazon.com/AmazonS3/latest/dev/UsingKMSEncryption.html) in the
    /// *Amazon Simple Storage Service Console Developer Guide*.
    ///
    /// If you use the `AES256` encryption type, Amazon ECR uses server-side
    /// encryption
    /// with Amazon S3-managed encryption keys which encrypts the images in the
    /// repository using an
    /// AES256 encryption algorithm. For more information, see [Protecting data
    /// using
    /// server-side encryption with Amazon S3-managed encryption keys
    /// (SSE-S3)](https://docs.aws.amazon.com/AmazonS3/latest/dev/UsingServerSideEncryption.html) in the
    /// *Amazon Simple Storage Service Console Developer Guide*.
    encryption_type: EncryptionType,

    /// If you use the `KMS` encryption type, specify the KMS key to use for
    /// encryption. The full ARN of the KMS key must be specified. The key must
    /// exist in the
    /// same Region as the repository. If no key is specified, the default Amazon
    /// Web Services managed KMS
    /// key for Amazon ECR will be used.
    kms_key: ?[]const u8 = null,

    pub const json_field_names = .{
        .encryption_type = "encryptionType",
        .kms_key = "kmsKey",
    };
};
