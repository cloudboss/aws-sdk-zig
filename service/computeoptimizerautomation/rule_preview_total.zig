const EstimatedMonthlySavings = @import("estimated_monthly_savings.zig").EstimatedMonthlySavings;

/// Aggregate totals for automation rule preview results, including count and
/// estimated savings.
pub const RulePreviewTotal = struct {
    estimated_monthly_savings: EstimatedMonthlySavings,

    /// The total number of recommended actions matching the rule preview
    /// configuration.
    recommended_action_count: i32,

    pub const json_field_names = .{
        .estimated_monthly_savings = "estimatedMonthlySavings",
        .recommended_action_count = "recommendedActionCount",
    };
};
