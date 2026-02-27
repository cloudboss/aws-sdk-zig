const S3ServerSideEncryptionType = @import("s3_server_side_encryption_type.zig").S3ServerSideEncryptionType;

/// Settings for how your job outputs are encrypted as they are uploaded to
/// Amazon S3.
pub const S3EncryptionSettings = struct {
    /// Specify how you want your data keys managed. AWS uses data keys to encrypt
    /// your content. AWS also encrypts the data keys themselves, using a customer
    /// master key (CMK), and then stores the encrypted data keys alongside your
    /// encrypted content. Use this setting to specify which AWS service manages the
    /// CMK. For simplest set up, choose Amazon S3. If you want your master key to
    /// be managed by AWS Key Management Service (KMS), choose AWS KMS. By default,
    /// when you choose AWS KMS, KMS uses the AWS managed customer master key (CMK)
    /// associated with Amazon S3 to encrypt your data keys. You can optionally
    /// choose to specify a different, customer managed CMK. Do so by specifying the
    /// Amazon Resource Name (ARN) of the key for the setting KMS ARN.
    encryption_type: ?S3ServerSideEncryptionType,

    /// Optionally, specify the encryption context that you want to use alongside
    /// your KMS key. AWS KMS uses this encryption context as additional
    /// authenticated data (AAD) to support authenticated encryption. This value
    /// must be a base64-encoded UTF-8 string holding JSON which represents a
    /// string-string map. To use this setting, you must also set Server-side
    /// encryption to AWS KMS. For more information about encryption context, see:
    /// https://docs.aws.amazon.com/kms/latest/developerguide/concepts.html#encrypt_context.
    kms_encryption_context: ?[]const u8,

    /// Optionally, specify the customer master key (CMK) that you want to use to
    /// encrypt the data key that AWS uses to encrypt your output content. Enter the
    /// Amazon Resource Name (ARN) of the CMK. To use this setting, you must also
    /// set Server-side encryption to AWS KMS. If you set Server-side encryption to
    /// AWS KMS but don't specify a CMK here, AWS uses the AWS managed CMK
    /// associated with Amazon S3.
    kms_key_arn: ?[]const u8,

    pub const json_field_names = .{
        .encryption_type = "EncryptionType",
        .kms_encryption_context = "KmsEncryptionContext",
        .kms_key_arn = "KmsKeyArn",
    };
};
