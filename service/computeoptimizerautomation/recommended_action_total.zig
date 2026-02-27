const EstimatedMonthlySavings = @import("estimated_monthly_savings.zig").EstimatedMonthlySavings;

/// Aggregate totals for a group of recommended actions, including count and
/// estimated monthly savings.
pub const RecommendedActionTotal = struct {
    estimated_monthly_savings: EstimatedMonthlySavings,

    /// The total number of recommended actions in this group.
    recommended_action_count: i32,

    pub const json_field_names = .{
        .estimated_monthly_savings = "estimatedMonthlySavings",
        .recommended_action_count = "recommendedActionCount",
    };
};
