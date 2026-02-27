/// The log configuration.
pub const AwsElasticsearchDomainLogPublishingOptionsLogConfig = struct {
    /// The ARN of the CloudWatch Logs group to publish the logs to.
    cloud_watch_logs_log_group_arn: ?[]const u8,

    /// Whether the log publishing is enabled.
    enabled: ?bool,

    pub const json_field_names = .{
        .cloud_watch_logs_log_group_arn = "CloudWatchLogsLogGroupArn",
        .enabled = "Enabled",
    };
};
