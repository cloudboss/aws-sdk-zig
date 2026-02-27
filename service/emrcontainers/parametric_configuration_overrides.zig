const Configuration = @import("configuration.zig").Configuration;
const ParametricMonitoringConfiguration = @import("parametric_monitoring_configuration.zig").ParametricMonitoringConfiguration;

/// A configuration specification to be used to override existing
/// configurations. This data
/// type allows job template parameters to be specified within.
pub const ParametricConfigurationOverrides = struct {
    /// The configurations for the application running by the job run.
    application_configuration: ?[]const Configuration,

    /// The configurations for monitoring.
    monitoring_configuration: ?ParametricMonitoringConfiguration,

    pub const json_field_names = .{
        .application_configuration = "applicationConfiguration",
        .monitoring_configuration = "monitoringConfiguration",
    };
};
