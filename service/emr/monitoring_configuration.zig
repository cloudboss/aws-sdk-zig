const CloudWatchLogConfiguration = @import("cloud_watch_log_configuration.zig").CloudWatchLogConfiguration;
const S3LoggingConfiguration = @import("s3_logging_configuration.zig").S3LoggingConfiguration;

/// Contains CloudWatch log configuration and S3 logging configuration metadata
/// and settings.
pub const MonitoringConfiguration = struct {
    /// CloudWatch log configuration settings and metadata that specify settings
    /// like log files to monitor and where to send them.
    cloud_watch_log_configuration: ?CloudWatchLogConfiguration = null,

    /// S3 logging configuration that controls how different types of logs (system
    /// logs, application logs, and persistent UI logs) are uploaded to S3. Each log
    /// type can be configured with a specific upload policy.
    s3_logging_configuration: ?S3LoggingConfiguration = null,

    pub const json_field_names = .{
        .cloud_watch_log_configuration = "CloudWatchLogConfiguration",
        .s3_logging_configuration = "S3LoggingConfiguration",
    };
};
