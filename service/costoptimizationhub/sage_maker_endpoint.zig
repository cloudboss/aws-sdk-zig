const ResourceCostCalculation = @import("resource_cost_calculation.zig").ResourceCostCalculation;

/// The SageMaker endpoint recommendation details.
pub const SageMakerEndpoint = struct {
    cost_calculation: ?ResourceCostCalculation = null,

    pub const json_field_names = .{
        .cost_calculation = "costCalculation",
    };
};
