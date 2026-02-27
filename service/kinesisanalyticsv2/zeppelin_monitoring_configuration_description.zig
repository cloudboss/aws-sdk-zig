const LogLevel = @import("log_level.zig").LogLevel;

/// The monitoring configuration for Apache Zeppelin within a Managed Service
/// for Apache Flink Studio notebook.
pub const ZeppelinMonitoringConfigurationDescription = struct {
    /// Describes the verbosity of the CloudWatch Logs for an application.
    log_level: ?LogLevel,

    pub const json_field_names = .{
        .log_level = "LogLevel",
    };
};
