const EstimatedDiscounts = @import("estimated_discounts.zig").EstimatedDiscounts;

/// Contains pricing information about the specified resource.
pub const ResourcePricing = struct {
    /// The savings estimate incorporating all discounts with Amazon Web Services,
    /// such as Reserved Instances and Savings Plans.
    estimated_cost_after_discounts: ?f64 = null,

    /// The savings estimate using Amazon Web Services public pricing without
    /// incorporating any discounts.
    estimated_cost_before_discounts: ?f64 = null,

    /// The estimated discounts for a recommendation.
    estimated_discounts: ?EstimatedDiscounts = null,

    /// The estimated net unused amortized commitment for the recommendation.
    estimated_net_unused_amortized_commitments: ?f64 = null,

    pub const json_field_names = .{
        .estimated_cost_after_discounts = "estimatedCostAfterDiscounts",
        .estimated_cost_before_discounts = "estimatedCostBeforeDiscounts",
        .estimated_discounts = "estimatedDiscounts",
        .estimated_net_unused_amortized_commitments = "estimatedNetUnusedAmortizedCommitments",
    };
};
