/// Configuration settings for delivering logs to Amazon S3 buckets.
pub const ManagedLoggingConfiguration = struct {
    /// Enables mamanged log persistence.
    enabled: bool,

    /// The KMS key ARN to encrypt the logs stored in managed log persistence.
    kms_key: ?[]const u8 = null,

    pub const json_field_names = .{
        .enabled = "Enabled",
        .kms_key = "KmsKey",
    };
};
