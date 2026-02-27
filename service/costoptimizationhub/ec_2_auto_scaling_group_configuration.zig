const AllocationStrategy = @import("allocation_strategy.zig").AllocationStrategy;
const InstanceConfiguration = @import("instance_configuration.zig").InstanceConfiguration;
const MixedInstanceConfiguration = @import("mixed_instance_configuration.zig").MixedInstanceConfiguration;
const Ec2AutoScalingGroupType = @import("ec_2_auto_scaling_group_type.zig").Ec2AutoScalingGroupType;

/// The EC2 Auto Scaling group configuration used for recommendations.
pub const Ec2AutoScalingGroupConfiguration = struct {
    /// The strategy used for allocating instances, based on a predefined priority
    /// order or based on the lowest available price.
    allocation_strategy: ?AllocationStrategy,

    /// Details about the instance for the EC2 Auto Scaling group with a single
    /// instance type.
    instance: ?InstanceConfiguration,

    /// A list of instance types for an EC2 Auto Scaling group with mixed instance
    /// types.
    mixed_instances: ?[]const MixedInstanceConfiguration,

    /// The type of EC2 Auto Scaling group, showing whether it consists of a single
    /// instance type or mixed instance types.
    type: ?Ec2AutoScalingGroupType,

    pub const json_field_names = .{
        .allocation_strategy = "allocationStrategy",
        .instance = "instance",
        .mixed_instances = "mixedInstances",
        .type = "type",
    };
};
