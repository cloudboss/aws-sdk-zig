/// The Amazon EC2 launch template that can be used by
/// a Spot Fleet to configure Amazon EC2 instances. You must specify either the
/// ID or name of the launch template in the request, but not both.
///
/// For information about launch templates,
/// see [Launch an instance from a launch
/// template](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ec2-launch-templates.html) in the
/// *Amazon EC2 User Guide*.
pub const FleetLaunchTemplateSpecification = struct {
    /// The ID of the launch template.
    ///
    /// You must specify the `LaunchTemplateId` or the `LaunchTemplateName`, but not
    /// both.
    launch_template_id: ?[]const u8,

    /// The name of the launch template.
    ///
    /// You must specify the `LaunchTemplateName` or the `LaunchTemplateId`, but not
    /// both.
    launch_template_name: ?[]const u8,

    /// The launch template version number, `$Latest`, or `$Default`.
    /// You must specify a value, otherwise the request fails.
    ///
    /// If the value is `$Latest`, Amazon EC2 uses the latest version of the launch
    /// template.
    ///
    /// If the value is `$Default`, Amazon EC2 uses the default version of the
    /// launch
    /// template.
    version: ?[]const u8,
};
