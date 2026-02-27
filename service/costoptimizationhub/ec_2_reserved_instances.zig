const Ec2ReservedInstancesConfiguration = @import("ec_2_reserved_instances_configuration.zig").Ec2ReservedInstancesConfiguration;
const ReservedInstancesCostCalculation = @import("reserved_instances_cost_calculation.zig").ReservedInstancesCostCalculation;

/// The EC2 reserved instances recommendation details.
pub const Ec2ReservedInstances = struct {
    /// The EC2 reserved instances configuration used for recommendations.
    configuration: ?Ec2ReservedInstancesConfiguration,

    /// Cost impact of the purchase recommendation.
    cost_calculation: ?ReservedInstancesCostCalculation,

    pub const json_field_names = .{
        .configuration = "configuration",
        .cost_calculation = "costCalculation",
    };
};
