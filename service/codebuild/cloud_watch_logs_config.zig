const LogsConfigStatusType = @import("logs_config_status_type.zig").LogsConfigStatusType;

/// Information about CloudWatch Logs for a build project.
pub const CloudWatchLogsConfig = struct {
    /// The group name of the logs in CloudWatch Logs. For more information, see
    /// [Working
    /// with Log Groups and Log
    /// Streams](https://docs.aws.amazon.com/AmazonCloudWatch/latest/logs/Working-with-log-groups-and-streams.html).
    group_name: ?[]const u8 = null,

    /// The current status of the logs in CloudWatch Logs for a build project. Valid
    /// values are:
    ///
    /// * `ENABLED`: CloudWatch Logs are enabled for this build project.
    ///
    /// * `DISABLED`: CloudWatch Logs are not enabled for this build project.
    status: LogsConfigStatusType,

    /// The prefix of the stream name of the CloudWatch Logs. For more information,
    /// see [Working
    /// with Log Groups and Log
    /// Streams](https://docs.aws.amazon.com/AmazonCloudWatch/latest/logs/Working-with-log-groups-and-streams.html).
    stream_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .group_name = "groupName",
        .status = "status",
        .stream_name = "streamName",
    };
};
