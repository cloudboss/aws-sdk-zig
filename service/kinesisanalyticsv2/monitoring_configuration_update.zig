const ConfigurationType = @import("configuration_type.zig").ConfigurationType;
const LogLevel = @import("log_level.zig").LogLevel;
const MetricsLevel = @import("metrics_level.zig").MetricsLevel;

/// Describes updates to configuration parameters for Amazon CloudWatch logging
/// for an application.
pub const MonitoringConfigurationUpdate = struct {
    /// Describes updates to whether to use the default CloudWatch logging
    /// configuration for
    /// an application. You must set this property to `CUSTOM` in order to set the
    /// `LogLevel` or
    /// `MetricsLevel` parameters.
    configuration_type_update: ?ConfigurationType,

    /// Describes updates to the verbosity of the CloudWatch Logs for an
    /// application.
    log_level_update: ?LogLevel,

    /// Describes updates to the granularity of the CloudWatch Logs for an
    /// application. The `Parallelism`
    /// level is not recommended for applications with a Parallelism over 64 due to
    /// excessive costs.
    metrics_level_update: ?MetricsLevel,

    pub const json_field_names = .{
        .configuration_type_update = "ConfigurationTypeUpdate",
        .log_level_update = "LogLevelUpdate",
        .metrics_level_update = "MetricsLevelUpdate",
    };
};
