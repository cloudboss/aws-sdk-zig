const CostAmount = @import("cost_amount.zig").CostAmount;

/// Represents the difference between historical and estimated costs.
pub const CostDifference = struct {
    /// The estimated cost amount.
    estimated_cost: ?CostAmount,

    /// The historical cost amount.
    historical_cost: ?CostAmount,

    pub const json_field_names = .{
        .estimated_cost = "estimatedCost",
        .historical_cost = "historicalCost",
    };
};
