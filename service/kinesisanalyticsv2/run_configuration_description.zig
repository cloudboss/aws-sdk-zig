const ApplicationRestoreConfiguration = @import("application_restore_configuration.zig").ApplicationRestoreConfiguration;
const FlinkRunConfiguration = @import("flink_run_configuration.zig").FlinkRunConfiguration;

/// Describes the starting properties for a Managed Service for Apache Flink
/// application.
pub const RunConfigurationDescription = struct {
    /// Describes the restore behavior of a restarting application.
    application_restore_configuration_description: ?ApplicationRestoreConfiguration,

    flink_run_configuration_description: ?FlinkRunConfiguration,

    pub const json_field_names = .{
        .application_restore_configuration_description = "ApplicationRestoreConfigurationDescription",
        .flink_run_configuration_description = "FlinkRunConfigurationDescription",
    };
};
