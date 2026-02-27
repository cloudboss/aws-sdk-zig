const RedshiftReservedInstancesConfiguration = @import("redshift_reserved_instances_configuration.zig").RedshiftReservedInstancesConfiguration;
const ReservedInstancesCostCalculation = @import("reserved_instances_cost_calculation.zig").ReservedInstancesCostCalculation;

/// The Redshift reserved instances recommendation details.
pub const RedshiftReservedInstances = struct {
    /// The Redshift reserved instances configuration used for recommendations.
    configuration: ?RedshiftReservedInstancesConfiguration,

    /// Cost impact of the purchase recommendation.
    cost_calculation: ?ReservedInstancesCostCalculation,

    pub const json_field_names = .{
        .configuration = "configuration",
        .cost_calculation = "costCalculation",
    };
};
