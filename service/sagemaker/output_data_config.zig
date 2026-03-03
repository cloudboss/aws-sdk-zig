const OutputCompressionType = @import("output_compression_type.zig").OutputCompressionType;

/// Provides information about how to store model training results (model
/// artifacts).
pub const OutputDataConfig = struct {
    /// The model output compression type. Select `None` to output an uncompressed
    /// model, recommended for large model outputs. Defaults to gzip.
    compression_type: ?OutputCompressionType = null,

    /// The Amazon Web Services Key Management Service (Amazon Web Services KMS) key
    /// that SageMaker uses to encrypt the model artifacts at rest using Amazon S3
    /// server-side encryption. The `KmsKeyId` can be any of the following formats:
    ///
    /// * // KMS Key ID
    ///
    /// `"1234abcd-12ab-34cd-56ef-1234567890ab"`
    /// * // Amazon Resource Name (ARN) of a KMS Key
    ///
    /// `"arn:aws:kms:us-west-2:111122223333:key/1234abcd-12ab-34cd-56ef-1234567890ab"`
    /// * // KMS Key Alias
    ///
    /// `"alias/ExampleAlias"`
    /// * // Amazon Resource Name (ARN) of a KMS Key Alias
    ///
    /// `"arn:aws:kms:us-west-2:111122223333:alias/ExampleAlias"`
    ///
    /// If you use a KMS key ID or an alias of your KMS key, the SageMaker execution
    /// role must include permissions to call `kms:Encrypt`. If you don't provide a
    /// KMS key ID, SageMaker uses the default KMS key for Amazon S3 for your role's
    /// account. For more information, see [KMS-Managed Encryption
    /// Keys](https://docs.aws.amazon.com/AmazonS3/latest/userguide/UsingKMSEncryption.html) in the *Amazon Simple Storage Service Developer Guide*. If the output data is stored in Amazon S3 Express One Zone, it is encrypted with server-side encryption with Amazon S3 managed keys (SSE-S3). KMS key is not supported for Amazon S3 Express One Zone
    ///
    /// The KMS key policy must grant permission to the IAM role that you specify in
    /// your `CreateTrainingJob`, `CreateTransformJob`, or
    /// `CreateHyperParameterTuningJob` requests. For more information, see [Using
    /// Key Policies in Amazon Web Services
    /// KMS](https://docs.aws.amazon.com/kms/latest/developerguide/key-policies.html) in the *Amazon Web Services Key Management Service Developer Guide*.
    kms_key_id: ?[]const u8 = null,

    /// Identifies the S3 path where you want SageMaker to store the model
    /// artifacts. For example, `s3://bucket-name/key-name-prefix`.
    s3_output_path: []const u8,

    pub const json_field_names = .{
        .compression_type = "CompressionType",
        .kms_key_id = "KmsKeyId",
        .s3_output_path = "S3OutputPath",
    };
};
