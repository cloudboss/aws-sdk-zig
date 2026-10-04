const InstancesDistribution = @import("instances_distribution.zig").InstancesDistribution;
const LaunchTemplate = @import("launch_template.zig").LaunchTemplate;

/// Use this structure to launch multiple instance types and configure how
/// capacity is
/// distributed across On-Demand, Spot, and supported Capacity Reservation types
/// within a
/// single Auto Scaling group.
///
/// A mixed instances policy contains information that Amazon EC2 Auto Scaling
/// can use to launch
/// instances, prioritize capacity types, and help optimize your costs. For more
/// information, see [Auto Scaling
/// groups with multiple instance types and purchase
/// options](https://docs.aws.amazon.com/autoscaling/ec2/userguide/ec2-auto-scaling-mixed-instances-groups.html) in the
/// *Amazon EC2 Auto Scaling User Guide*. To learn how to prioritize multiple
/// capacity
/// types, see [Use Distribution
/// Segments to target multiple capacity
/// types](https://docs.aws.amazon.com/autoscaling/ec2/userguide/use-distribution-segments.html) in the
/// *Amazon EC2 Auto Scaling User Guide*.
pub const MixedInstancesPolicy = struct {
    /// The instances distribution.
    instances_distribution: ?InstancesDistribution = null,

    /// One or more launch templates and the instance types (overrides) that are
    /// used to
    /// launch EC2 instances to fulfill the configured capacities.
    launch_template: ?LaunchTemplate = null,
};
