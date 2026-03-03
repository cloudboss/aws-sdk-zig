const CloudWatchLogsConfig = @import("cloud_watch_logs_config.zig").CloudWatchLogsConfig;
const S3LogsConfig = @import("s3_logs_config.zig").S3LogsConfig;

/// Information about logs for a build project. These can be logs in CloudWatch
/// Logs, built in a
/// specified S3 bucket, or both.
pub const LogsConfig = struct {
    /// Information about CloudWatch Logs for a build project. CloudWatch Logs are
    /// enabled by default.
    cloud_watch_logs: ?CloudWatchLogsConfig = null,

    /// Information about logs built to an S3 bucket for a build project. S3 logs
    /// are not
    /// enabled by default.
    s_3_logs: ?S3LogsConfig = null,

    pub const json_field_names = .{
        .cloud_watch_logs = "cloudWatchLogs",
        .s_3_logs = "s3Logs",
    };
};
