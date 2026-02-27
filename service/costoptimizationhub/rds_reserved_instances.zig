const RdsReservedInstancesConfiguration = @import("rds_reserved_instances_configuration.zig").RdsReservedInstancesConfiguration;
const ReservedInstancesCostCalculation = @import("reserved_instances_cost_calculation.zig").ReservedInstancesCostCalculation;

/// The RDS reserved instances recommendation details.
pub const RdsReservedInstances = struct {
    /// The RDS reserved instances configuration used for recommendations.
    configuration: ?RdsReservedInstancesConfiguration,

    /// Cost impact of the purchase recommendation.
    cost_calculation: ?ReservedInstancesCostCalculation,

    pub const json_field_names = .{
        .configuration = "configuration",
        .cost_calculation = "costCalculation",
    };
};
