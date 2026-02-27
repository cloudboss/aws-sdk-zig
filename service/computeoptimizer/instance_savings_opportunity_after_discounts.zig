const InstanceEstimatedMonthlySavings = @import("instance_estimated_monthly_savings.zig").InstanceEstimatedMonthlySavings;

/// Describes the savings opportunity for instance recommendations after
/// applying the Savings Plans and Reserved Instances discounts.
///
/// Savings opportunity after discounts represents the estimated monthly savings
/// you can achieve by
/// implementing Compute Optimizer recommendations.
pub const InstanceSavingsOpportunityAfterDiscounts = struct {
    /// An object that describes the estimated monthly savings possible by adopting
    /// Compute Optimizer’s Amazon EC2 instance recommendations. This is
    /// based on pricing after applying the Savings Plans and Reserved Instances
    /// discounts.
    estimated_monthly_savings: ?InstanceEstimatedMonthlySavings,

    /// The estimated monthly savings possible as a percentage of monthly cost after
    /// applying the Savings Plans and Reserved Instances discounts.
    /// This saving can be achieved by adopting Compute Optimizer’s EC2 instance
    /// recommendations.
    savings_opportunity_percentage: f64 = 0,

    pub const json_field_names = .{
        .estimated_monthly_savings = "estimatedMonthlySavings",
        .savings_opportunity_percentage = "savingsOpportunityPercentage",
    };
};
