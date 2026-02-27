/// Details about the launch template to use.
pub const AwsAutoScalingAutoScalingGroupLaunchTemplateLaunchTemplateSpecification = struct {
    /// The identifier of the launch template. You must specify either
    /// `LaunchTemplateId` or `LaunchTemplateName`.
    launch_template_id: ?[]const u8,

    /// The name of the launch template. You must specify either `LaunchTemplateId`
    /// or `LaunchTemplateName`.
    launch_template_name: ?[]const u8,

    /// Identifies the version of the launch template. You can specify a version
    /// identifier, or use the values `$Latest` or `$Default`.
    version: ?[]const u8,

    pub const json_field_names = .{
        .launch_template_id = "LaunchTemplateId",
        .launch_template_name = "LaunchTemplateName",
        .version = "Version",
    };
};
