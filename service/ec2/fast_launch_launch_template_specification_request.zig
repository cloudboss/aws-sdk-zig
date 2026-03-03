/// Request to create a launch template for a Windows fast launch enabled AMI.
///
/// Note - You can specify either the `LaunchTemplateName` or the
/// `LaunchTemplateId`, but not both.
pub const FastLaunchLaunchTemplateSpecificationRequest = struct {
    /// Specify the ID of the launch template that the AMI should use for Windows
    /// fast
    /// launch.
    launch_template_id: ?[]const u8 = null,

    /// Specify the name of the launch template that the AMI should use for Windows
    /// fast
    /// launch.
    launch_template_name: ?[]const u8 = null,

    /// Specify the version of the launch template that the AMI should use for
    /// Windows fast
    /// launch.
    version: []const u8,
};
