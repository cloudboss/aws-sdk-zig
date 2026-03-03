const Configuration = @import("configuration.zig").Configuration;
const MonitoringConfiguration = @import("monitoring_configuration.zig").MonitoringConfiguration;

/// A configuration specification to be used to override existing
/// configurations.
pub const ConfigurationOverrides = struct {
    /// The configurations for the application running by the job run.
    application_configuration: ?[]const Configuration = null,

    /// The configurations for monitoring.
    monitoring_configuration: ?MonitoringConfiguration = null,

    pub const json_field_names = .{
        .application_configuration = "applicationConfiguration",
        .monitoring_configuration = "monitoringConfiguration",
    };
};
