const ElastiCacheReservedInstancesConfiguration = @import("elasti_cache_reserved_instances_configuration.zig").ElastiCacheReservedInstancesConfiguration;
const ReservedInstancesCostCalculation = @import("reserved_instances_cost_calculation.zig").ReservedInstancesCostCalculation;

/// The ElastiCache reserved instances recommendation details.
pub const ElastiCacheReservedInstances = struct {
    /// The ElastiCache reserved instances configuration used for recommendations.
    configuration: ?ElastiCacheReservedInstancesConfiguration,

    /// Cost impact of the purchase recommendation.
    cost_calculation: ?ReservedInstancesCostCalculation,

    pub const json_field_names = .{
        .configuration = "configuration",
        .cost_calculation = "costCalculation",
    };
};
