const LoggingLevel = @import("logging_level.zig").LoggingLevel;

/// Describes the Apache Airflow log details for the log type (e.g.
/// `DagProcessingLogs`).
pub const ModuleLoggingConfiguration = struct {
    /// The Amazon Resource Name (ARN) for the CloudWatch Logs group where the
    /// Apache Airflow log type (e.g. `DagProcessingLogs`) is published. For
    /// example,
    /// `arn:aws:logs:us-east-1:123456789012:log-group:airflow-MyMWAAEnvironment-MwaaEnvironment-DAGProcessing:*`.
    cloud_watch_log_group_arn: ?[]const u8,

    /// Indicates whether the Apache Airflow log type (e.g. `DagProcessingLogs`) is
    /// enabled.
    enabled: ?bool,

    /// The Apache Airflow log level for the log type (e.g. `DagProcessingLogs`).
    log_level: ?LoggingLevel,

    pub const json_field_names = .{
        .cloud_watch_log_group_arn = "CloudWatchLogGroupArn",
        .enabled = "Enabled",
        .log_level = "LogLevel",
    };
};
