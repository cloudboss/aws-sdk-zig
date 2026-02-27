const LogLevel = @import("log_level.zig").LogLevel;

/// Describes configuration parameters for Amazon CloudWatch logging for a
/// Managed Service for Apache Flink Studio notebook. For more information about
/// CloudWatch logging, see
/// [Monitoring](https://docs.aws.amazon.com/kinesisanalytics/latest/java/monitoring-overview.html).
pub const ZeppelinMonitoringConfiguration = struct {
    /// The verbosity of the CloudWatch Logs for an application.
    log_level: LogLevel,

    pub const json_field_names = .{
        .log_level = "LogLevel",
    };
};
