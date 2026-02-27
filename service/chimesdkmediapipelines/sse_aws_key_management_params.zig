/// Contains server side encryption parameters to be used by media capture
/// pipeline. The
/// parameters can also be used by media concatenation pipeline taking media
/// capture pipeline
/// as a media source.
pub const SseAwsKeyManagementParams = struct {
    /// Base64-encoded string of a UTF-8 encoded JSON, which contains the encryption
    /// context as
    /// non-secret key-value pair known as encryption context pairs, that provides
    /// an added layer
    /// of security for your data. For more information, see [KMS encryption
    /// context](https://docs.aws.amazon.com/kms/latest/developerguide/encrypt_context.html) and [Asymmetric keys in KMS](https://docs.aws.amazon.com/kms/latest/developerguide/symmetric-asymmetric.html) in the *Key Management Service Developer
    /// Guide*.
    aws_kms_encryption_context: ?[]const u8,

    /// The KMS key you want to use to encrypt your media pipeline output.
    /// Decryption is required for concatenation pipeline. If using a key located in
    /// the current
    /// Amazon Web Services account, you can specify your KMS key in one of four
    /// ways:
    ///
    /// * Use the KMS key ID itself. For example,
    /// `1234abcd-12ab-34cd-56ef-1234567890ab`.
    ///
    /// * Use an alias for the KMS key ID. For example,
    /// `alias/ExampleAlias`.
    ///
    /// * Use the Amazon Resource Name (ARN) for the KMS key ID. For example,
    /// `arn:aws:kms:region:account-ID:key/1234abcd-12ab-34cd-56ef-1234567890ab`.
    ///
    /// * Use the ARN for the KMS key alias. For example,
    /// `arn:aws:kms:region:account-ID:alias/ExampleAlias`.
    ///
    /// If using a key located in a different Amazon Web Services account than the
    /// current
    /// Amazon Web Services account, you can specify your KMS key in one of two
    /// ways:
    ///
    /// * Use the ARN for the KMS key ID. For example,
    /// `arn:aws:kms:region:account-ID:key/1234abcd-12ab-34cd-56ef-1234567890ab`.
    ///
    /// * Use the ARN for the KMS key alias. For example,
    /// `arn:aws:kms:region:account-ID:alias/ExampleAlias`.
    ///
    /// If you don't specify an encryption key, your output is encrypted with the
    /// default
    /// Amazon S3 key (SSE-S3).
    ///
    /// Note that the role specified in the `SinkIamRoleArn` request parameter must
    /// have permission to use the specified KMS key.
    aws_kms_key_id: []const u8,

    pub const json_field_names = .{
        .aws_kms_encryption_context = "AwsKmsEncryptionContext",
        .aws_kms_key_id = "AwsKmsKeyId",
    };
};
