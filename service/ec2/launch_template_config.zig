const FleetLaunchTemplateSpecification = @import("fleet_launch_template_specification.zig").FleetLaunchTemplateSpecification;
const LaunchTemplateOverrides = @import("launch_template_overrides.zig").LaunchTemplateOverrides;

/// Describes a launch template and overrides.
pub const LaunchTemplateConfig = struct {
    /// The launch template to use. Make sure that the launch template does not
    /// contain the
    /// `NetworkInterfaceId` parameter because you can't specify a network interface
    /// ID in a Spot Fleet.
    launch_template_specification: ?FleetLaunchTemplateSpecification = null,

    /// Any parameters that you specify override the same parameters in the launch
    /// template.
    overrides: ?[]const LaunchTemplateOverrides = null,
};
