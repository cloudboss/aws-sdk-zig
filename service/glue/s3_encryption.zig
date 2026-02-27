const S3EncryptionMode = @import("s3_encryption_mode.zig").S3EncryptionMode;

/// Specifies how Amazon Simple Storage Service (Amazon S3) data should be
/// encrypted.
pub const S3Encryption = struct {
    /// The Amazon Resource Name (ARN) of the KMS key to be used to encrypt the
    /// data.
    kms_key_arn: ?[]const u8,

    /// The encryption mode to use for Amazon S3 data.
    s3_encryption_mode: ?S3EncryptionMode,

    pub const json_field_names = .{
        .kms_key_arn = "KmsKeyArn",
        .s3_encryption_mode = "S3EncryptionMode",
    };
};
