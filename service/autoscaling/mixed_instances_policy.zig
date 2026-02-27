const InstancesDistribution = @import("instances_distribution.zig").InstancesDistribution;
const LaunchTemplate = @import("launch_template.zig").LaunchTemplate;

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
pub const MixedInstancesPolicy = struct {
    /// The instances distribution.
    instances_distribution: ?InstancesDistribution,

    /// One or more launch templates and the instance types (overrides) that are
    /// used to
    /// launch EC2 instances to fulfill On-Demand and Spot capacities.
    launch_template: ?LaunchTemplate,
};
