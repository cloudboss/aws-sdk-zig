const AllocationStrategy = @import("allocation_strategy.zig").AllocationStrategy;
const AsgType = @import("asg_type.zig").AsgType;

/// Describes the configuration of an EC2 Amazon EC2 Auto Scaling group.
pub const AutoScalingGroupConfiguration = struct {
    /// Describes the allocation strategy that the EC2 Amazon EC2 Auto Scaling group
    /// uses. This field is only available for EC2 Amazon EC2 Auto Scaling groups
    /// with mixed instance types.
    allocation_strategy: ?AllocationStrategy = null,

    /// The desired capacity, or number of instances, for the EC2 Amazon EC2 Auto
    /// Scaling group.
    desired_capacity: i32 = 0,

    /// Describes the projected percentage reduction in instance hours after
    /// adopting the recommended configuration. This field is only available for EC2
    /// Amazon EC2 Auto Scaling groups with scaling policies.
    estimated_instance_hour_reduction_percentage: ?f64 = null,

    /// The instance type for the EC2 Amazon EC2 Auto Scaling group.
    instance_type: ?[]const u8 = null,

    /// The maximum size, or maximum number of instances, for the EC2 Amazon EC2
    /// Auto Scaling
    /// group.
    max_size: i32 = 0,

    /// The minimum size, or minimum number of instances, for the EC2 Amazon EC2
    /// Auto Scaling
    /// group.
    min_size: i32 = 0,

    /// List the instance types within an EC2 Amazon EC2 Auto Scaling group that has
    /// mixed instance types.
    mixed_instance_types: ?[]const []const u8 = null,

    /// Describes whether the EC2 Amazon EC2 Auto Scaling group has a single
    /// instance type or a mixed instance type configuration.
    @"type": ?AsgType = null,

    pub const json_field_names = .{
        .allocation_strategy = "allocationStrategy",
        .desired_capacity = "desiredCapacity",
        .estimated_instance_hour_reduction_percentage = "estimatedInstanceHourReductionPercentage",
        .instance_type = "instanceType",
        .max_size = "maxSize",
        .min_size = "minSize",
        .mixed_instance_types = "mixedInstanceTypes",
        .@"type" = "type",
    };
};
