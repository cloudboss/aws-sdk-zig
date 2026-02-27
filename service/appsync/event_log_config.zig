const EventLogLevel = @import("event_log_level.zig").EventLogLevel;

/// Describes the CloudWatch Logs configuration for the Event API.
pub const EventLogConfig = struct {
    /// The IAM service role that AppSync assumes to publish CloudWatch Logs in your
    /// account.
    cloud_watch_logs_role_arn: []const u8,

    /// The type of information to log for the Event API.
    log_level: EventLogLevel,

    pub const json_field_names = .{
        .cloud_watch_logs_role_arn = "cloudWatchLogsRoleArn",
        .log_level = "logLevel",
    };
};
