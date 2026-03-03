const IdleEstimatedMonthlySavings = @import("idle_estimated_monthly_savings.zig").IdleEstimatedMonthlySavings;

/// Describes the savings opportunity for idle resource recommendations.
pub const IdleSavingsOpportunity = struct {
    /// The estimated monthly savings possible by adopting Compute Optimizer's idle
    /// resource recommendations.
    estimated_monthly_savings: ?IdleEstimatedMonthlySavings = null,

    /// The estimated monthly savings possible as a percentage of monthly cost by
    /// adopting Compute Optimizer's idle resource recommendations.
    savings_opportunity_percentage: f64 = 0,

    pub const json_field_names = .{
        .estimated_monthly_savings = "estimatedMonthlySavings",
        .savings_opportunity_percentage = "savingsOpportunityPercentage",
    };
};
