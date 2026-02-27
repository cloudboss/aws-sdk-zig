const S3EncryptionConfig = @import("s3_encryption_config.zig").S3EncryptionConfig;

/// A structure that contains the configuration for canary artifacts, including
/// the
/// encryption-at-rest settings for artifacts that the canary uploads to Amazon
/// S3.
pub const ArtifactConfigInput = struct {
    /// A structure that contains the configuration of the encryption-at-rest
    /// settings for artifacts that the canary uploads
    /// to Amazon S3.
    /// Artifact encryption functionality is available only for canaries that use
    /// Synthetics runtime version
    /// syn-nodejs-puppeteer-3.3 or later. For more information, see
    /// [Encrypting canary
    /// artifacts](https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/CloudWatch_Synthetics_artifact_encryption.html)
    s3_encryption: ?S3EncryptionConfig,

    pub const json_field_names = .{
        .s3_encryption = "S3Encryption",
    };
};
