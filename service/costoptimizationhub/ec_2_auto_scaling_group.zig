const Ec2AutoScalingGroupConfiguration = @import("ec_2_auto_scaling_group_configuration.zig").Ec2AutoScalingGroupConfiguration;
const ResourceCostCalculation = @import("resource_cost_calculation.zig").ResourceCostCalculation;

/// The EC2 Auto Scaling group recommendation details.
pub const Ec2AutoScalingGroup = struct {
    /// The EC2 Auto Scaling group configuration used for recommendations.
    configuration: ?Ec2AutoScalingGroupConfiguration = null,

    /// Cost impact of the recommendation.
    cost_calculation: ?ResourceCostCalculation = null,

    pub const json_field_names = .{
        .configuration = "configuration",
        .cost_calculation = "costCalculation",
    };
};
