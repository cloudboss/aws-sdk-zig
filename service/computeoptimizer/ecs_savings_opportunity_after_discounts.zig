const ECSEstimatedMonthlySavings = @import("ecs_estimated_monthly_savings.zig").ECSEstimatedMonthlySavings;

/// Describes the savings opportunity for Amazon ECS service recommendations
/// after applying Savings Plans discounts.
///
/// Savings opportunity represents the estimated monthly savings after applying
/// Savings Plans discounts.
/// You can achieve this by implementing a given Compute Optimizer
/// recommendation.
pub const ECSSavingsOpportunityAfterDiscounts = struct {
    /// The estimated monthly savings possible by adopting Compute Optimizer’s
    /// Amazon ECS service recommendations.
    /// This includes any applicable Savings Plans discounts.
    estimated_monthly_savings: ?ECSEstimatedMonthlySavings,

    /// The estimated monthly savings possible as a percentage of monthly cost by
    /// adopting Compute Optimizer’s
    /// Amazon ECS service recommendations. This includes any applicable Savings
    /// Plans discounts.
    savings_opportunity_percentage: f64 = 0,

    pub const json_field_names = .{
        .estimated_monthly_savings = "estimatedMonthlySavings",
        .savings_opportunity_percentage = "savingsOpportunityPercentage",
    };
};
