const AutoScalingGroupEstimatedMonthlySavings = @import("auto_scaling_group_estimated_monthly_savings.zig").AutoScalingGroupEstimatedMonthlySavings;

/// Describes the savings opportunity for Amazon EC2 Auto Scaling group
/// recommendations after applying the Savings Plans and Reserved Instances
/// discounts.
///
/// Savings opportunity represents the estimated monthly savings you can achieve
/// by implementing Compute Optimizer recommendations.
pub const AutoScalingGroupSavingsOpportunityAfterDiscounts = struct {
    /// An object that describes the estimated monthly savings possible by adopting
    /// Compute Optimizer’s Amazon EC2 Auto Scaling group recommendations. This is
    /// based on the
    /// Savings Plans and Reserved Instances pricing discounts.
    estimated_monthly_savings: ?AutoScalingGroupEstimatedMonthlySavings,

    /// The estimated monthly savings possible as a percentage of monthly cost after
    /// applying the Savings Plans and Reserved Instances discounts. This saving can
    /// be
    /// achieved by adopting Compute Optimizer’s Amazon EC2 Auto Scaling group
    /// recommendations.
    savings_opportunity_percentage: f64 = 0,

    pub const json_field_names = .{
        .estimated_monthly_savings = "estimatedMonthlySavings",
        .savings_opportunity_percentage = "savingsOpportunityPercentage",
    };
};
