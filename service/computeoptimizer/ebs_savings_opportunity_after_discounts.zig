const EBSEstimatedMonthlySavings = @import("ebs_estimated_monthly_savings.zig").EBSEstimatedMonthlySavings;

/// Describes the savings opportunity for Amazon EBS volume recommendations
/// after applying specific discounts.
pub const EBSSavingsOpportunityAfterDiscounts = struct {
    /// The estimated monthly savings possible as a percentage of monthly cost by
    /// adopting Compute Optimizer’s Amazon EBS volume
    /// recommendations. This saving includes any applicable discounts.
    estimated_monthly_savings: ?EBSEstimatedMonthlySavings = null,

    /// The estimated monthly savings possible as a percentage of monthly cost after
    /// applying the specific discounts.
    /// This saving can be achieved by adopting Compute Optimizer’s Amazon EBS
    /// volume recommendations.
    savings_opportunity_percentage: f64 = 0,

    pub const json_field_names = .{
        .estimated_monthly_savings = "estimatedMonthlySavings",
        .savings_opportunity_percentage = "savingsOpportunityPercentage",
    };
};
