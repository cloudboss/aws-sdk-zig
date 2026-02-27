const LogLevel = @import("log_level.zig").LogLevel;

/// Updates to the monitoring configuration for Apache Zeppelin within a Managed
/// Service for Apache Flink Studio notebook.
pub const ZeppelinMonitoringConfigurationUpdate = struct {
    /// Updates to the logging level for Apache Zeppelin within a Managed Service
    /// for Apache Flink Studio notebook.
    log_level_update: LogLevel,

    pub const json_field_names = .{
        .log_level_update = "LogLevelUpdate",
    };
};
