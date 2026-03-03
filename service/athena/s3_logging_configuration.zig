/// Configuration settings for delivering logs to Amazon S3 buckets.
pub const S3LoggingConfiguration = struct {
    /// Enables S3 log delivery.
    enabled: bool,

    /// The KMS key ARN to encrypt the logs published to the given Amazon S3
    /// destination.
    kms_key: ?[]const u8 = null,

    /// The Amazon S3 destination URI for log publishing.
    log_location: ?[]const u8 = null,

    pub const json_field_names = .{
        .enabled = "Enabled",
        .kms_key = "KmsKey",
        .log_location = "LogLocation",
    };
};
