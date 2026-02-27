const IdleEstimatedMonthlySavings = @import("idle_estimated_monthly_savings.zig").IdleEstimatedMonthlySavings;

/// Describes the savings opportunity for idle resource recommendations after
/// applying discounts.
///
/// Savings opportunity represents the estimated monthly savings after applying
/// discounts. You can achieve this by implementing a given Compute Optimizer
/// recommendation.
pub const IdleSavingsOpportunityAfterDiscounts = struct {
    /// The estimated monthly savings possible by adopting Compute Optimizer's idle
    /// resource recommendations. This includes any applicable discounts.
    estimated_monthly_savings: ?IdleEstimatedMonthlySavings,

    /// The estimated monthly savings possible as a percentage of monthly cost by
    /// adopting Compute Optimizer's idle resource recommendations. This includes
    /// any applicable discounts.
    savings_opportunity_percentage: f64 = 0,

    pub const json_field_names = .{
        .estimated_monthly_savings = "estimatedMonthlySavings",
        .savings_opportunity_percentage = "savingsOpportunityPercentage",
    };
};
