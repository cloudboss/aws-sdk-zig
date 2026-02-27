const ConfigurationType = @import("configuration_type.zig").ConfigurationType;
const LogLevel = @import("log_level.zig").LogLevel;
const MetricsLevel = @import("metrics_level.zig").MetricsLevel;

/// Describes configuration parameters for Amazon CloudWatch logging for an
/// application. For more information about CloudWatch logging, see
/// [Monitoring](https://docs.aws.amazon.com/kinesisanalytics/latest/java/monitoring-overview.html).
pub const MonitoringConfiguration = struct {
    /// Describes whether to use the default CloudWatch logging configuration for an
    /// application.
    /// You must set this property to `CUSTOM` in order to set the `LogLevel` or
    /// `MetricsLevel` parameters.
    configuration_type: ConfigurationType,

    /// Describes the verbosity of the CloudWatch Logs for an application.
    log_level: ?LogLevel,

    /// Describes the granularity of the CloudWatch Logs for an application. The
    /// `Parallelism`
    /// level is not recommended for applications with a Parallelism over 64 due to
    /// excessive costs.
    metrics_level: ?MetricsLevel,

    pub const json_field_names = .{
        .configuration_type = "ConfigurationType",
        .log_level = "LogLevel",
        .metrics_level = "MetricsLevel",
    };
};
