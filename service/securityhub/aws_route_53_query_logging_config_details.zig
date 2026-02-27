const CloudWatchLogsLogGroupArnConfigDetails = @import("cloud_watch_logs_log_group_arn_config_details.zig").CloudWatchLogsLogGroupArnConfigDetails;

/// Provides details about a specified Amazon Route 53 configuration for DNS
/// query logging.
pub const AwsRoute53QueryLoggingConfigDetails = struct {
    /// The Amazon Resource Name (ARN) of the Amazon CloudWatch Logs log group that
    /// Route 53 is publishing logs to.
    cloud_watch_logs_log_group_arn: ?CloudWatchLogsLogGroupArnConfigDetails,

    pub const json_field_names = .{
        .cloud_watch_logs_log_group_arn = "CloudWatchLogsLogGroupArn",
    };
};
