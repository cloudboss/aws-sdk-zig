const LaunchTemplateSpecification = @import("launch_template_specification.zig").LaunchTemplateSpecification;
const MixedInstancesPolicy = @import("mixed_instances_policy.zig").MixedInstancesPolicy;

/// Describes the desired configuration for an instance refresh.
///
/// If you specify a desired configuration, you must specify either a
/// `LaunchTemplate` or a `MixedInstancesPolicy`.
pub const DesiredConfiguration = struct {
    /// Describes the launch template and the version of the launch template that
    /// Amazon EC2 Auto Scaling
    /// uses to launch Amazon EC2 instances. For more information about launch
    /// templates, see [Launch
    /// templates](https://docs.aws.amazon.com/autoscaling/ec2/userguide/launch-templates.html) in the *Amazon EC2 Auto Scaling User Guide*.
    launch_template: ?LaunchTemplateSpecification = null,

    /// Use this structure to launch multiple instance types and On-Demand Instances
    /// and Spot
    /// Instances within a single Auto Scaling group.
    ///
    /// A mixed instances policy contains information that Amazon EC2 Auto Scaling
    /// can use to launch
    /// instances and help optimize your costs. For more information, see [Auto
    /// Scaling
    /// groups with multiple instance types and purchase
    /// options](https://docs.aws.amazon.com/autoscaling/ec2/userguide/ec2-auto-scaling-mixed-instances-groups.html) in the
    /// *Amazon EC2 Auto Scaling User Guide*.
    mixed_instances_policy: ?MixedInstancesPolicy = null,
};
