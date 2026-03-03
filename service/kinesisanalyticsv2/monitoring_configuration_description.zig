const ConfigurationType = @import("configuration_type.zig").ConfigurationType;
const LogLevel = @import("log_level.zig").LogLevel;
const MetricsLevel = @import("metrics_level.zig").MetricsLevel;

/// Describes configuration parameters for CloudWatch logging for an
/// application.
pub const MonitoringConfigurationDescription = struct {
    /// Describes whether to use the default CloudWatch logging configuration for an
    /// application.
    configuration_type: ?ConfigurationType = null,

    /// Describes the verbosity of the CloudWatch Logs for an application.
    log_level: ?LogLevel = null,

    /// Describes the granularity of the CloudWatch Logs for an application.
    metrics_level: ?MetricsLevel = null,

    pub const json_field_names = .{
        .configuration_type = "ConfigurationType",
        .log_level = "LogLevel",
        .metrics_level = "MetricsLevel",
    };
};
