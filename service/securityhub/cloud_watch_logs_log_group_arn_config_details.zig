/// The Amazon Resource Name (ARN) and other details of the Amazon CloudWatch
/// Logs log group that Amazon Route 53 is
/// publishing logs to.
pub const CloudWatchLogsLogGroupArnConfigDetails = struct {
    /// The ARN of the CloudWatch Logs log group that Route 53 is publishing logs
    /// to.
    cloud_watch_logs_log_group_arn: ?[]const u8,

    /// The ID of the hosted zone that CloudWatch Logs is logging queries for.
    hosted_zone_id: ?[]const u8,

    /// The ID for a DNS query logging configuration.
    id: ?[]const u8,

    pub const json_field_names = .{
        .cloud_watch_logs_log_group_arn = "CloudWatchLogsLogGroupArn",
        .hosted_zone_id = "HostedZoneId",
        .id = "Id",
    };
};
