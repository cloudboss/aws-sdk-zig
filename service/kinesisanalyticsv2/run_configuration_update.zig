const ApplicationRestoreConfiguration = @import("application_restore_configuration.zig").ApplicationRestoreConfiguration;
const FlinkRunConfiguration = @import("flink_run_configuration.zig").FlinkRunConfiguration;

/// Describes the updates to the starting parameters for a Managed Service for
/// Apache Flink application.
pub const RunConfigurationUpdate = struct {
    /// Describes updates to the restore behavior of a restarting application.
    application_restore_configuration: ?ApplicationRestoreConfiguration = null,

    /// Describes the starting parameters for a Managed Service for Apache Flink
    /// application.
    flink_run_configuration: ?FlinkRunConfiguration = null,

    pub const json_field_names = .{
        .application_restore_configuration = "ApplicationRestoreConfiguration",
        .flink_run_configuration = "FlinkRunConfiguration",
    };
};
