const S3EncryptionConfig = @import("s3_encryption_config.zig").S3EncryptionConfig;

/// A structure that contains the configuration for canary artifacts, including
/// the encryption-at-rest settings for artifacts that the canary uploads to
/// Amazon S3.
pub const ArtifactConfigOutput = struct {
    /// A structure that contains the configuration of encryption settings for
    /// canary artifacts that are stored in Amazon S3.
    s3_encryption: ?S3EncryptionConfig,

    pub const json_field_names = .{
        .s3_encryption = "S3Encryption",
    };
};
