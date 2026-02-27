/// Cost optimizing aggregates for a Recommendation
pub const RecommendationCostOptimizingAggregates = struct {
    /// The estimated monthly savings
    estimated_monthly_savings: f64,

    /// The estimated percently monthly savings
    estimated_percent_monthly_savings: f64,

    pub const json_field_names = .{
        .estimated_monthly_savings = "estimatedMonthlySavings",
        .estimated_percent_monthly_savings = "estimatedPercentMonthlySavings",
    };
};
