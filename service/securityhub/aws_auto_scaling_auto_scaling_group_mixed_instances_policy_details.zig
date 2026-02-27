const AwsAutoScalingAutoScalingGroupMixedInstancesPolicyInstancesDistributionDetails = @import("aws_auto_scaling_auto_scaling_group_mixed_instances_policy_instances_distribution_details.zig").AwsAutoScalingAutoScalingGroupMixedInstancesPolicyInstancesDistributionDetails;
const AwsAutoScalingAutoScalingGroupMixedInstancesPolicyLaunchTemplateDetails = @import("aws_auto_scaling_auto_scaling_group_mixed_instances_policy_launch_template_details.zig").AwsAutoScalingAutoScalingGroupMixedInstancesPolicyLaunchTemplateDetails;

/// The mixed instances policy for the automatic scaling group.
pub const AwsAutoScalingAutoScalingGroupMixedInstancesPolicyDetails = struct {
    /// The instances distribution. The instances distribution specifies the
    /// distribution of On-Demand Instances and Spot Instances, the maximum price to
    /// pay for Spot Instances, and how the Auto Scaling group allocates instance
    /// types to fulfill On-Demand and Spot capacity.
    instances_distribution: ?AwsAutoScalingAutoScalingGroupMixedInstancesPolicyInstancesDistributionDetails,

    /// The launch template to use and the instance types (overrides) to use to
    /// provision EC2 instances to fulfill On-Demand and Spot capacities.
    launch_template: ?AwsAutoScalingAutoScalingGroupMixedInstancesPolicyLaunchTemplateDetails,

    pub const json_field_names = .{
        .instances_distribution = "InstancesDistribution",
        .launch_template = "LaunchTemplate",
    };
};
