/// The log configuration for the results of the run command actions.
pub const AwsEcsClusterConfigurationExecuteCommandConfigurationLogConfigurationDetails = struct {
    /// Whether to enable encryption on the CloudWatch logs.
    cloud_watch_encryption_enabled: ?bool = null,

    /// The name of the CloudWatch log group to send the logs to.
    cloud_watch_log_group_name: ?[]const u8 = null,

    /// The name of the S3 bucket to send logs to.
    s3_bucket_name: ?[]const u8 = null,

    /// Whether to encrypt the logs that are sent to the S3 bucket.
    s3_encryption_enabled: ?bool = null,

    /// Identifies the folder in the S3 bucket to send the logs to.
    s3_key_prefix: ?[]const u8 = null,

    pub const json_field_names = .{
        .cloud_watch_encryption_enabled = "CloudWatchEncryptionEnabled",
        .cloud_watch_log_group_name = "CloudWatchLogGroupName",
        .s3_bucket_name = "S3BucketName",
        .s3_encryption_enabled = "S3EncryptionEnabled",
        .s3_key_prefix = "S3KeyPrefix",
    };
};
