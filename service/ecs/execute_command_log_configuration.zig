/// The log configuration for the results of the execute command actions. The
/// logs can be sent to CloudWatch Logs or an Amazon S3 bucket.
pub const ExecuteCommandLogConfiguration = struct {
    /// Determines whether to use encryption on the CloudWatch logs. If not
    /// specified, encryption will be off.
    cloud_watch_encryption_enabled: bool = false,

    /// The name of the CloudWatch log group to send logs to.
    ///
    /// The CloudWatch log group must already be created.
    cloud_watch_log_group_name: ?[]const u8 = null,

    /// The name of the S3 bucket to send logs to.
    ///
    /// The S3 bucket must already be created.
    s_3_bucket_name: ?[]const u8 = null,

    /// Determines whether to use encryption on the S3 logs. If not specified,
    /// encryption is not used.
    s_3_encryption_enabled: bool = false,

    /// An optional folder in the S3 bucket to place logs in.
    s_3_key_prefix: ?[]const u8 = null,

    pub const json_field_names = .{
        .cloud_watch_encryption_enabled = "cloudWatchEncryptionEnabled",
        .cloud_watch_log_group_name = "cloudWatchLogGroupName",
        .s_3_bucket_name = "s3BucketName",
        .s_3_encryption_enabled = "s3EncryptionEnabled",
        .s_3_key_prefix = "s3KeyPrefix",
    };
};
