/// Identifies the launch template that the AMI uses for Windows fast launch.
pub const FastLaunchLaunchTemplateSpecificationResponse = struct {
    /// The ID of the launch template that the AMI uses for Windows fast launch.
    launch_template_id: ?[]const u8,

    /// The name of the launch template that the AMI uses for Windows fast launch.
    launch_template_name: ?[]const u8,

    /// The version of the launch template that the AMI uses for Windows fast
    /// launch.
    version: ?[]const u8,
};
