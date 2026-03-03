/// Identifies the launch template that the associated Windows AMI uses for
/// launching an
/// instance when faster launching is enabled.
///
/// You can specify either the `launchTemplateName` or the
/// `launchTemplateId`, but not both.
pub const FastLaunchLaunchTemplateSpecification = struct {
    /// The ID of the launch template to use for faster launching for a Windows AMI.
    launch_template_id: ?[]const u8 = null,

    /// The name of the launch template to use for faster launching for a Windows
    /// AMI.
    launch_template_name: ?[]const u8 = null,

    /// The version of the launch template to use for faster launching for a Windows
    /// AMI.
    launch_template_version: ?[]const u8 = null,

    pub const json_field_names = .{
        .launch_template_id = "launchTemplateId",
        .launch_template_name = "launchTemplateName",
        .launch_template_version = "launchTemplateVersion",
    };
};
