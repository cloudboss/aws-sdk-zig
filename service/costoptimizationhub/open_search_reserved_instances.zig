const OpenSearchReservedInstancesConfiguration = @import("open_search_reserved_instances_configuration.zig").OpenSearchReservedInstancesConfiguration;
const ReservedInstancesCostCalculation = @import("reserved_instances_cost_calculation.zig").ReservedInstancesCostCalculation;

/// The OpenSearch reserved instances recommendation details.
pub const OpenSearchReservedInstances = struct {
    /// The OpenSearch reserved instances configuration used for recommendations.
    configuration: ?OpenSearchReservedInstancesConfiguration = null,

    /// Cost impact of the purchase recommendation.
    cost_calculation: ?ReservedInstancesCostCalculation = null,

    pub const json_field_names = .{
        .configuration = "configuration",
        .cost_calculation = "costCalculation",
    };
};
