const ApplicationRestoreConfiguration = @import("application_restore_configuration.zig").ApplicationRestoreConfiguration;
const FlinkRunConfiguration = @import("flink_run_configuration.zig").FlinkRunConfiguration;
const SqlRunConfiguration = @import("sql_run_configuration.zig").SqlRunConfiguration;

/// Describes the starting parameters for an Managed Service for Apache Flink
/// application.
pub const RunConfiguration = struct {
    /// Describes the restore behavior of a restarting application.
    application_restore_configuration: ?ApplicationRestoreConfiguration,

    /// Describes the starting parameters for a Managed Service for Apache Flink
    /// application.
    flink_run_configuration: ?FlinkRunConfiguration,

    /// Describes the starting parameters for a SQL-based Kinesis Data Analytics
    /// application
    /// application.
    sql_run_configurations: ?[]const SqlRunConfiguration,

    pub const json_field_names = .{
        .application_restore_configuration = "ApplicationRestoreConfiguration",
        .flink_run_configuration = "FlinkRunConfiguration",
        .sql_run_configurations = "SqlRunConfigurations",
    };
};
