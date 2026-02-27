const LoggingLevel = @import("logging_level.zig").LoggingLevel;

/// Enables the Apache Airflow log type (e.g. `DagProcessingLogs`) and defines
/// the log level to send to CloudWatch Logs (e.g. `INFO`).
pub const ModuleLoggingConfigurationInput = struct {
    /// Indicates whether to enable the Apache Airflow log type (e.g.
    /// `DagProcessingLogs`).
    enabled: bool,

    /// Defines the Apache Airflow log level (e.g. `INFO`) to send to CloudWatch
    /// Logs.
    log_level: LoggingLevel,

    pub const json_field_names = .{
        .enabled = "Enabled",
        .log_level = "LogLevel",
    };
};
