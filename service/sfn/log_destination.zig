const CloudWatchLogsLogGroup = @import("cloud_watch_logs_log_group.zig").CloudWatchLogsLogGroup;

pub const LogDestination = struct {
    /// An object describing a CloudWatch log group. For more information, see
    /// [AWS::Logs::LogGroup](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-logs-loggroup.html) in the CloudFormation User Guide.
    cloud_watch_logs_log_group: ?CloudWatchLogsLogGroup,

    pub const json_field_names = .{
        .cloud_watch_logs_log_group = "cloudWatchLogsLogGroup",
    };
};
