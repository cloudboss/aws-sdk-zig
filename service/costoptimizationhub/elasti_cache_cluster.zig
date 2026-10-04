const ResourceCostCalculation = @import("resource_cost_calculation.zig").ResourceCostCalculation;

/// The ElastiCache cluster recommendation details.
pub const ElastiCacheCluster = struct {
    cost_calculation: ?ResourceCostCalculation = null,

    pub const json_field_names = .{
        .cost_calculation = "costCalculation",
    };
};
