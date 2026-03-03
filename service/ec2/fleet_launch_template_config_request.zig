const FleetLaunchTemplateSpecificationRequest = @import("fleet_launch_template_specification_request.zig").FleetLaunchTemplateSpecificationRequest;
const FleetLaunchTemplateOverridesRequest = @import("fleet_launch_template_overrides_request.zig").FleetLaunchTemplateOverridesRequest;

/// Describes a launch template and overrides.
pub const FleetLaunchTemplateConfigRequest = struct {
    /// The launch template to use. You must specify either the launch template ID
    /// or launch
    /// template name in the request.
    launch_template_specification: ?FleetLaunchTemplateSpecificationRequest = null,

    /// Any parameters that you specify override the same parameters in the launch
    /// template.
    ///
    /// For fleets of type `request` and `maintain`, a maximum of 300
    /// items is allowed across all launch templates.
    overrides: ?[]const FleetLaunchTemplateOverridesRequest = null,
};
