const S3EncryptionOption = @import("s3_encryption_option.zig").S3EncryptionOption;

/// The configuration that specifies an S3 location.
pub const S3Configuration = struct {
    /// The bucket name of the customer S3 bucket.
    bucket_name: ?[]const u8,

    /// The encryption option for the customer S3 location. Options are S3
    /// server-side
    /// encryption with an S3 managed key or Amazon Web Services managed key.
    encryption_option: ?S3EncryptionOption,

    /// The KMS key ID for the customer S3 location when encrypting with an
    /// Amazon Web Services managed key.
    kms_key_id: ?[]const u8,

    /// The object key preview for the customer S3 location.
    object_key_prefix: ?[]const u8,

    pub const json_field_names = .{
        .bucket_name = "BucketName",
        .encryption_option = "EncryptionOption",
        .kms_key_id = "KmsKeyId",
        .object_key_prefix = "ObjectKeyPrefix",
    };
};
