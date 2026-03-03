const SavingsPlansPricing = @import("savings_plans_pricing.zig").SavingsPlansPricing;

/// Cost impact of the purchase recommendation.
pub const SavingsPlansCostCalculation = struct {
    /// Pricing details of the purchase recommendation.
    pricing: ?SavingsPlansPricing = null,

    pub const json_field_names = .{
        .pricing = "pricing",
    };
};
