const CloudWatchLogsLogGroup = @import("cloud_watch_logs_log_group.zig").CloudWatchLogsLogGroup;

/// The location where SimSpace Weaver sends simulation log data.
pub const LogDestination = struct {
    /// An Amazon CloudWatch Logs log group that stores simulation log data. For
    /// more information about log groups, see [Working with log
    /// groups and log
    /// streams](https://docs.aws.amazon.com/AmazonCloudWatch/latest/logs/Working-with-log-groups-and-streams.html) in the *Amazon CloudWatch Logs User Guide*.
    cloud_watch_logs_log_group: ?CloudWatchLogsLogGroup,

    pub const json_field_names = .{
        .cloud_watch_logs_log_group = "CloudWatchLogsLogGroup",
    };
};
