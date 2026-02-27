/// The estimated cost savings that might be realized if the recommended
/// operations are
/// taken.
pub const TrustedAdvisorCostOptimizingSummary = struct {
    /// The estimated monthly savings that might be realized if the recommended
    /// operations are
    /// taken.
    estimated_monthly_savings: f64 = 0,

    /// The estimated percentage of savings that might be realized if the
    /// recommended
    /// operations are taken.
    estimated_percent_monthly_savings: f64 = 0,

    pub const json_field_names = .{
        .estimated_monthly_savings = "estimatedMonthlySavings",
        .estimated_percent_monthly_savings = "estimatedPercentMonthlySavings",
    };
};
