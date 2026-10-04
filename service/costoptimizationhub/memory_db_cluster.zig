const ResourceCostCalculation = @import("resource_cost_calculation.zig").ResourceCostCalculation;

/// The MemoryDB cluster recommendation details.
pub const MemoryDbCluster = struct {
    cost_calculation: ?ResourceCostCalculation = null,

    pub const json_field_names = .{
        .cost_calculation = "costCalculation",
    };
};
