/// Describes the launch template and the version of the launch template that
/// Amazon EC2 Auto Scaling
/// uses to launch Amazon EC2 instances. For more information about launch
/// templates, see [Launch
/// templates](https://docs.aws.amazon.com/autoscaling/ec2/userguide/launch-templates.html) in the *Amazon EC2 Auto Scaling User Guide*.
pub const LaunchTemplateSpecification = struct {
    /// The ID of the launch template. To get the template ID, use the Amazon EC2
    /// [DescribeLaunchTemplates](https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_DescribeLaunchTemplates.html) API operation. New launch templates can be created
    /// using the Amazon EC2
    /// [CreateLaunchTemplate](https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_CreateLaunchTemplate.html) API.
    ///
    /// Conditional: You must specify either a `LaunchTemplateId` or a
    /// `LaunchTemplateName`.
    launch_template_id: ?[]const u8,

    /// The name of the launch template. To get the template name, use the Amazon
    /// EC2
    /// [DescribeLaunchTemplates](https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_DescribeLaunchTemplates.html) API operation. New launch templates can be created
    /// using the Amazon EC2
    /// [CreateLaunchTemplate](https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_CreateLaunchTemplate.html) API.
    ///
    /// Conditional: You must specify either a `LaunchTemplateId` or a
    /// `LaunchTemplateName`.
    launch_template_name: ?[]const u8,

    /// The version number, `$Latest`, or `$Default`. To get the version
    /// number, use the Amazon EC2
    /// [DescribeLaunchTemplateVersions](https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_DescribeLaunchTemplateVersions.html) API operation. New launch template versions
    /// can be created using the Amazon EC2
    /// [CreateLaunchTemplateVersion](https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_CreateLaunchTemplateVersion.html) API. If the value is `$Latest`,
    /// Amazon EC2 Auto Scaling selects the latest version of the launch template
    /// when launching instances. If
    /// the value is `$Default`, Amazon EC2 Auto Scaling selects the default version
    /// of the launch
    /// template when launching instances. The default value is `$Default`.
    version: ?[]const u8,
};
