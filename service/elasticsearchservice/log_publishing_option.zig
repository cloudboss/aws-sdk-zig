/// Log Publishing option that is set for given domain.
///
/// Attributes and their details:
///
/// * CloudWatchLogsLogGroupArn: ARN of the Cloudwatch log group to which log
///   needs to be published.
///
/// * Enabled: Whether the log publishing for given log type is enabled or not
pub const LogPublishingOption = struct {
    cloud_watch_logs_log_group_arn: ?[]const u8 = null,

    /// Specifies whether given log publishing option is enabled or not.
    enabled: ?bool = null,

    pub const json_field_names = .{
        .cloud_watch_logs_log_group_arn = "CloudWatchLogsLogGroupArn",
        .enabled = "Enabled",
    };
};
