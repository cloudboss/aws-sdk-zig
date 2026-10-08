/// Configuration for test execution logging destinations.
pub const LoggingConfiguration = struct {
    /// The ARN of the CloudWatch Logs log group for log delivery.
    cloud_watch_log_group_arn: ?[]const u8 = null,

    /// The version of the log schema.
    log_schema_version: ?[]const u8 = null,

    /// The name of the S3 bucket for log delivery.
    s_3_bucket_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .cloud_watch_log_group_arn = "cloudWatchLogGroupArn",
        .log_schema_version = "logSchemaVersion",
        .s_3_bucket_name = "s3BucketName",
    };
};
