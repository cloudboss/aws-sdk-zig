/// Specifies whether the Amazon OpenSearch Service domain publishes the
/// OpenSearch
/// application and slow logs to Amazon CloudWatch. For more information, see
/// [Monitoring OpenSearch logs with Amazon CloudWatch
/// Logs](https://docs.aws.amazon.com/opensearch-service/latest/developerguide/createdomain-configure-slow-logs.html).
///
/// After you enable log publishing, you still have to enable the collection of
/// slow
/// logs using the OpenSearch REST API.
pub const LogPublishingOption = struct {
    /// The Amazon Resource Name (ARN) of the CloudWatch Logs group to publish logs
    /// to.
    cloud_watch_logs_log_group_arn: ?[]const u8,

    /// Whether the log should be published.
    enabled: ?bool,

    pub const json_field_names = .{
        .cloud_watch_logs_log_group_arn = "CloudWatchLogsLogGroupArn",
        .enabled = "Enabled",
    };
};
