/// The encryption configuration details.
pub const EncryptionConfiguration = struct {
    /// The Amazon Resource Name (ARN) of the KMS key to use for encryption. This
    /// field is required only when `sseAlgorithm` is set to `aws:kms`.
    kms_key_arn: ?[]const u8 = null,

    /// The server-side encryption algorithm to use. Valid values are AES256 for
    /// S3-managed encryption keys, or aws:kms for Amazon Web Services KMS-managed
    /// encryption keys. If you choose SSE-KMS encryption you must grant the S3
    /// Tables maintenance principal access to your KMS key. For more information,
    /// see [Permissions requirements for S3 Tables SSE-KMS
    /// encryption](https://docs.aws.amazon.com/AmazonS3/latest/userguide/s3-tables-kms-permissions.html).
    sse_algorithm: ?[]const u8 = null,

    pub const json_field_names = .{
        .kms_key_arn = "kmsKeyArn",
        .sse_algorithm = "sseAlgorithm",
    };
};
