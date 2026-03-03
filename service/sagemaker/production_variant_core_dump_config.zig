/// Specifies configuration for a core dump from the model container when the
/// process crashes.
pub const ProductionVariantCoreDumpConfig = struct {
    /// The Amazon S3 bucket to send the core dump to.
    destination_s3_uri: []const u8,

    /// The Amazon Web Services Key Management Service (Amazon Web Services KMS) key
    /// that SageMaker uses to encrypt the core dump data at rest using Amazon S3
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
    /// account. SageMaker uses server-side encryption with KMS-managed keys for
    /// `OutputDataConfig`. If you use a bucket policy with an `s3:PutObject`
    /// permission that only allows objects with server-side encryption, set the
    /// condition key of `s3:x-amz-server-side-encryption` to `"aws:kms"`. For more
    /// information, see [KMS-Managed Encryption
    /// Keys](https://docs.aws.amazon.com/AmazonS3/latest/dev/UsingKMSEncryption.html) in the *Amazon Simple Storage Service Developer Guide.*
    ///
    /// The KMS key policy must grant permission to the IAM role that you specify in
    /// your `CreateEndpoint` and `UpdateEndpoint` requests. For more information,
    /// see [Using Key Policies in Amazon Web Services
    /// KMS](https://docs.aws.amazon.com/kms/latest/developerguide/key-policies.html) in the *Amazon Web Services Key Management Service Developer Guide*.
    kms_key_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .destination_s3_uri = "DestinationS3Uri",
        .kms_key_id = "KmsKeyId",
    };
};
