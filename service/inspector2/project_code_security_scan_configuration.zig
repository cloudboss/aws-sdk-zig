const ProjectContinuousIntegrationScanConfiguration = @import("project_continuous_integration_scan_configuration.zig").ProjectContinuousIntegrationScanConfiguration;
const ProjectPeriodicScanConfiguration = @import("project_periodic_scan_configuration.zig").ProjectPeriodicScanConfiguration;

/// Contains the scan configuration settings applied to a specific project in a
/// code
/// repository.
pub const ProjectCodeSecurityScanConfiguration = struct {
    /// The continuous integration scan configurations applied to the project.
    continuous_integration_scan_configurations: ?[]const ProjectContinuousIntegrationScanConfiguration,

    /// The periodic scan configurations applied to the project.
    periodic_scan_configurations: ?[]const ProjectPeriodicScanConfiguration,

    pub const json_field_names = .{
        .continuous_integration_scan_configurations = "continuousIntegrationScanConfigurations",
        .periodic_scan_configurations = "periodicScanConfigurations",
    };
};
