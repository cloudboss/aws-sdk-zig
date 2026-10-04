/// Amazon S3 configuration for monitoring log publishing. You can configure
/// your jobs to
/// send log information to Amazon S3.
pub const S3MonitoringConfiguration = struct {
    /// The Amazon Resource Name (ARN) of the encryption key for logs.
    encryption_key_arn: ?[]const u8 = null,

    /// Amazon S3 destination URI for log publishing.
    log_uri: []const u8,

    pub const json_field_names = .{
        .encryption_key_arn = "encryptionKeyArn",
        .log_uri = "logUri",
    };
};
