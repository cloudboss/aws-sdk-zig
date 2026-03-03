const CloudWatchLogsConfig = @import("cloud_watch_logs_config.zig").CloudWatchLogsConfig;
const S3LogsConfig = @import("s3_logs_config.zig").S3LogsConfig;

/// Information about build logs in CloudWatch Logs.
pub const LogsLocation = struct {
    /// Information about CloudWatch Logs for a build project.
    cloud_watch_logs: ?CloudWatchLogsConfig = null,

    /// The ARN of the CloudWatch Logs stream for a build execution. Its format is
    /// `arn:${Partition}:logs:${Region}:${Account}:log-group:${LogGroupName}:log-stream:${LogStreamName}`.
    /// The CloudWatch Logs stream is created during the PROVISIONING phase of a
    /// build and the ARN will not be valid until it is created. For more
    /// information, see [Resources Defined by CloudWatch
    /// Logs](https://docs.aws.amazon.com/IAM/latest/UserGuide/list_amazoncloudwatchlogs.html#amazoncloudwatchlogs-resources-for-iam-policies).
    cloud_watch_logs_arn: ?[]const u8 = null,

    /// The URL to an individual build log in CloudWatch Logs. The log stream is
    /// created during the PROVISIONING phase of a build and the `deeplink` will not
    /// be valid until it is created.
    deep_link: ?[]const u8 = null,

    /// The name of the CloudWatch Logs group for the build logs.
    group_name: ?[]const u8 = null,

    /// The URL to a build log in an S3 bucket.
    s_3_deep_link: ?[]const u8 = null,

    /// Information about S3 logs for a build project.
    s_3_logs: ?S3LogsConfig = null,

    /// The ARN of S3 logs for a build project. Its format is
    /// `arn:${Partition}:s3:::${BucketName}/${ObjectName}`. For more
    /// information, see [Resources Defined by Amazon
    /// S3](https://docs.aws.amazon.com/IAM/latest/UserGuide/list_amazons3.html#amazons3-resources-for-iam-policies).
    s_3_logs_arn: ?[]const u8 = null,

    /// The name of the CloudWatch Logs stream for the build logs.
    stream_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .cloud_watch_logs = "cloudWatchLogs",
        .cloud_watch_logs_arn = "cloudWatchLogsArn",
        .deep_link = "deepLink",
        .group_name = "groupName",
        .s_3_deep_link = "s3DeepLink",
        .s_3_logs = "s3Logs",
        .s_3_logs_arn = "s3LogsArn",
        .stream_name = "streamName",
    };
};
