const ResourceCostCalculation = @import("resource_cost_calculation.zig").ResourceCostCalculation;

/// The Amazon DocumentDB cluster recommendation details.
pub const DocumentDbCluster = struct {
    cost_calculation: ?ResourceCostCalculation = null,

    pub const json_field_names = .{
        .cost_calculation = "costCalculation",
    };
};
