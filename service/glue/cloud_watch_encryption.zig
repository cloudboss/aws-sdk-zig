const CloudWatchEncryptionMode = @import("cloud_watch_encryption_mode.zig").CloudWatchEncryptionMode;

/// Specifies how Amazon CloudWatch data should be encrypted.
pub const CloudWatchEncryption = struct {
    /// The encryption mode to use for CloudWatch data.
    cloud_watch_encryption_mode: ?CloudWatchEncryptionMode = null,

    /// The Amazon Resource Name (ARN) of the KMS key to be used to encrypt the
    /// data.
    kms_key_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .cloud_watch_encryption_mode = "CloudWatchEncryptionMode",
        .kms_key_arn = "KmsKeyArn",
    };
};
