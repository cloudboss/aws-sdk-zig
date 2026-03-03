const FleetLaunchTemplateSpecification = @import("fleet_launch_template_specification.zig").FleetLaunchTemplateSpecification;
const FleetLaunchTemplateOverrides = @import("fleet_launch_template_overrides.zig").FleetLaunchTemplateOverrides;

/// Describes a launch template and overrides.
pub const LaunchTemplateAndOverridesResponse = struct {
    /// The launch template.
    launch_template_specification: ?FleetLaunchTemplateSpecification = null,

    /// Any parameters that you specify override the same parameters in the launch
    /// template.
    overrides: ?FleetLaunchTemplateOverrides = null,
};
