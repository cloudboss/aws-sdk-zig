const LaunchTemplateSpecification = @import("launch_template_specification.zig").LaunchTemplateSpecification;
const LaunchTemplateOverrides = @import("launch_template_overrides.zig").LaunchTemplateOverrides;

/// Use this structure to specify the launch templates and instance types
/// (overrides) for
/// a mixed instances policy.
pub const LaunchTemplate = struct {
    /// The launch template.
    launch_template_specification: ?LaunchTemplateSpecification,

    /// Any properties that you specify override the same properties in the launch
    /// template.
    overrides: ?[]const LaunchTemplateOverrides,
};
