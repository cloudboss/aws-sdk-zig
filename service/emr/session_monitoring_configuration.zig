const SessionCloudWatchLoggingConfiguration = @import("session_cloud_watch_logging_configuration.zig").SessionCloudWatchLoggingConfiguration;
const SessionManagedLoggingConfiguration = @import("session_managed_logging_configuration.zig").SessionManagedLoggingConfiguration;
const SessionS3LoggingConfiguration = @import("session_s3_logging_configuration.zig").SessionS3LoggingConfiguration;

/// The monitoring configuration for a session. Controls where session logs are
/// published.
pub const SessionMonitoringConfiguration = struct {
    /// The CloudWatch Logs configuration for the session.
    cloud_watch_logging_configuration: ?SessionCloudWatchLoggingConfiguration = null,

    /// The Amazon EMR-managed logging configuration for the session.
    managed_logging_configuration: ?SessionManagedLoggingConfiguration = null,

    /// The Amazon S3 logging configuration for the session.
    s3_logging_configuration: ?SessionS3LoggingConfiguration = null,

    pub const json_field_names = .{
        .cloud_watch_logging_configuration = "CloudWatchLoggingConfiguration",
        .managed_logging_configuration = "ManagedLoggingConfiguration",
        .s3_logging_configuration = "S3LoggingConfiguration",
    };
};
