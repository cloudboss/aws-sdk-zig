const Ec2InstanceConfiguration = @import("ec_2_instance_configuration.zig").Ec2InstanceConfiguration;
const ResourceCostCalculation = @import("resource_cost_calculation.zig").ResourceCostCalculation;

/// Describes the EC2 instance configuration of the current and recommended
/// resource configuration for a recommendation.
pub const Ec2Instance = struct {
    /// The EC2 instance configuration used for recommendations.
    configuration: ?Ec2InstanceConfiguration = null,

    /// Cost impact of the recommendation.
    cost_calculation: ?ResourceCostCalculation = null,

    pub const json_field_names = .{
        .configuration = "configuration",
        .cost_calculation = "costCalculation",
    };
};
