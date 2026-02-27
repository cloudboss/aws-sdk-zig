const AwsAutoScalingAutoScalingGroupMixedInstancesPolicyLaunchTemplateLaunchTemplateSpecification = @import("aws_auto_scaling_auto_scaling_group_mixed_instances_policy_launch_template_launch_template_specification.zig").AwsAutoScalingAutoScalingGroupMixedInstancesPolicyLaunchTemplateLaunchTemplateSpecification;
const AwsAutoScalingAutoScalingGroupMixedInstancesPolicyLaunchTemplateOverridesListDetails = @import("aws_auto_scaling_auto_scaling_group_mixed_instances_policy_launch_template_overrides_list_details.zig").AwsAutoScalingAutoScalingGroupMixedInstancesPolicyLaunchTemplateOverridesListDetails;

/// Describes a launch template and overrides for a mixed instances policy.
pub const AwsAutoScalingAutoScalingGroupMixedInstancesPolicyLaunchTemplateDetails = struct {
    /// The launch template to use for a mixed instances policy.
    launch_template_specification: ?AwsAutoScalingAutoScalingGroupMixedInstancesPolicyLaunchTemplateLaunchTemplateSpecification,

    /// Property values to use to override the values in the launch template.
    overrides: ?[]const AwsAutoScalingAutoScalingGroupMixedInstancesPolicyLaunchTemplateOverridesListDetails,

    pub const json_field_names = .{
        .launch_template_specification = "LaunchTemplateSpecification",
        .overrides = "Overrides",
    };
};
