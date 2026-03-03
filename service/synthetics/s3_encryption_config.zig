const EncryptionMode = @import("encryption_mode.zig").EncryptionMode;

/// A structure that contains the configuration of encryption-at-rest settings
/// for canary artifacts that the canary
/// uploads to Amazon S3.
///
/// For more information, see
/// [Encrypting canary
/// artifacts](https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/CloudWatch_Synthetics_artifact_encryption.html)
pub const S3EncryptionConfig = struct {
    /// The encryption method to use for artifacts created by this canary. Specify
    /// `SSE_S3` to use
    /// server-side encryption (SSE) with an Amazon S3-managed
    /// key. Specify `SSE-KMS` to use server-side encryption with a customer-managed
    /// KMS key.
    ///
    /// If you omit this parameter, an
    /// Amazon Web Services-managed KMS key is used.
    encryption_mode: ?EncryptionMode = null,

    /// The ARN of the customer-managed KMS key to use, if you specify `SSE-KMS`
    /// for `EncryptionMode`
    kms_key_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .encryption_mode = "EncryptionMode",
        .kms_key_arn = "KmsKeyArn",
    };
};
