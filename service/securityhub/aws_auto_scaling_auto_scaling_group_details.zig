const AwsAutoScalingAutoScalingGroupAvailabilityZonesListDetails = @import("aws_auto_scaling_auto_scaling_group_availability_zones_list_details.zig").AwsAutoScalingAutoScalingGroupAvailabilityZonesListDetails;
const AwsAutoScalingAutoScalingGroupLaunchTemplateLaunchTemplateSpecification = @import("aws_auto_scaling_auto_scaling_group_launch_template_launch_template_specification.zig").AwsAutoScalingAutoScalingGroupLaunchTemplateLaunchTemplateSpecification;
const AwsAutoScalingAutoScalingGroupMixedInstancesPolicyDetails = @import("aws_auto_scaling_auto_scaling_group_mixed_instances_policy_details.zig").AwsAutoScalingAutoScalingGroupMixedInstancesPolicyDetails;

/// Provides details about an auto scaling group.
pub const AwsAutoScalingAutoScalingGroupDetails = struct {
    /// The list of Availability Zones for the automatic scaling group.
    availability_zones: ?[]const AwsAutoScalingAutoScalingGroupAvailabilityZonesListDetails,

    /// Indicates whether capacity rebalancing is enabled.
    capacity_rebalance: ?bool,

    /// Indicates when the auto scaling group was created.
    ///
    /// For more information about the validation and formatting of timestamp fields
    /// in Security Hub, see
    /// [Timestamps](https://docs.aws.amazon.com/securityhub/1.0/APIReference/Welcome.html#timestamps).
    created_time: ?[]const u8,

    /// The amount of time, in seconds, that Amazon EC2 Auto Scaling waits before it
    /// checks the
    /// health status of an EC2 instance that has come into service.
    health_check_grace_period: ?i32,

    /// The service to use for the health checks. Valid values are `EC2` or `ELB`.
    health_check_type: ?[]const u8,

    /// The name of the launch configuration.
    launch_configuration_name: ?[]const u8,

    /// The launch template to use.
    launch_template: ?AwsAutoScalingAutoScalingGroupLaunchTemplateLaunchTemplateSpecification,

    /// The list of load balancers associated with the group.
    load_balancer_names: ?[]const []const u8,

    /// The mixed instances policy for the automatic scaling group.
    mixed_instances_policy: ?AwsAutoScalingAutoScalingGroupMixedInstancesPolicyDetails,

    pub const json_field_names = .{
        .availability_zones = "AvailabilityZones",
        .capacity_rebalance = "CapacityRebalance",
        .created_time = "CreatedTime",
        .health_check_grace_period = "HealthCheckGracePeriod",
        .health_check_type = "HealthCheckType",
        .launch_configuration_name = "LaunchConfigurationName",
        .launch_template = "LaunchTemplate",
        .load_balancer_names = "LoadBalancerNames",
        .mixed_instances_policy = "MixedInstancesPolicy",
    };
};
