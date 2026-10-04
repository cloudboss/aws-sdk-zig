const ResourceCostCalculation = @import("resource_cost_calculation.zig").ResourceCostCalculation;

/// The DynamoDB table recommendation details.
pub const DynamoDbTable = struct {
    cost_calculation: ?ResourceCostCalculation = null,

    pub const json_field_names = .{
        .cost_calculation = "costCalculation",
    };
};
