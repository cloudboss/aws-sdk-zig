/// Configuration details for a log publishing option.
pub const AwsOpenSearchServiceDomainLogPublishingOption = struct {
    /// The ARN of the CloudWatch Logs group to publish the logs to.
    cloud_watch_logs_log_group_arn: ?[]const u8 = null,

    /// Whether the log publishing is enabled.
    enabled: ?bool = null,

    pub const json_field_names = .{
        .cloud_watch_logs_log_group_arn = "CloudWatchLogsLogGroupArn",
        .enabled = "Enabled",
    };
};
