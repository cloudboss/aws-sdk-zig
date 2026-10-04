const ResourceCostCalculation = @import("resource_cost_calculation.zig").ResourceCostCalculation;

/// The WorkSpaces recommendation details.
pub const WorkSpaces = struct {
    cost_calculation: ?ResourceCostCalculation = null,

    pub const json_field_names = .{
        .cost_calculation = "costCalculation",
    };
};
