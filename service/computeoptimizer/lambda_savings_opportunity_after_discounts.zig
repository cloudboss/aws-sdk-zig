const LambdaEstimatedMonthlySavings = @import("lambda_estimated_monthly_savings.zig").LambdaEstimatedMonthlySavings;

/// Describes the savings opportunity for Lambda functions recommendations after
/// applying Savings Plans discounts.
///
/// Savings opportunity represents the estimated monthly savings after applying
/// Savings Plans discounts.
/// You can achieve this by implementing a given Compute Optimizer
/// recommendation.
pub const LambdaSavingsOpportunityAfterDiscounts = struct {
    /// The estimated monthly savings possible by adopting Compute Optimizer’s
    /// Lambda function recommendations. This
    /// includes any applicable Savings Plans discounts.
    estimated_monthly_savings: ?LambdaEstimatedMonthlySavings = null,

    /// The estimated monthly savings possible as a percentage of monthly cost by
    /// adopting Compute Optimizer’s Lambda
    /// function recommendations. This includes any applicable Savings Plans
    /// discounts.
    savings_opportunity_percentage: f64 = 0,

    pub const json_field_names = .{
        .estimated_monthly_savings = "estimatedMonthlySavings",
        .savings_opportunity_percentage = "savingsOpportunityPercentage",
    };
};
