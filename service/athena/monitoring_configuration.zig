const CloudWatchLoggingConfiguration = @import("cloud_watch_logging_configuration.zig").CloudWatchLoggingConfiguration;
const ManagedLoggingConfiguration = @import("managed_logging_configuration.zig").ManagedLoggingConfiguration;
const S3LoggingConfiguration = @import("s3_logging_configuration.zig").S3LoggingConfiguration;

/// Contains the configuration settings for managed log persistence, delivering
/// logs to Amazon S3 buckets,
/// Amazon CloudWatch log groups etc.
pub const MonitoringConfiguration = struct {
    /// Configuration settings for delivering logs to Amazon CloudWatch log groups.
    cloud_watch_logging_configuration: ?CloudWatchLoggingConfiguration,

    /// Configuration settings for managed log persistence.
    managed_logging_configuration: ?ManagedLoggingConfiguration,

    /// Configuration settings for delivering logs to Amazon S3 buckets.
    s3_logging_configuration: ?S3LoggingConfiguration,

    pub const json_field_names = .{
        .cloud_watch_logging_configuration = "CloudWatchLoggingConfiguration",
        .managed_logging_configuration = "ManagedLoggingConfiguration",
        .s3_logging_configuration = "S3LoggingConfiguration",
    };
};
