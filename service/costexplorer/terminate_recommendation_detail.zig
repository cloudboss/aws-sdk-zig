/// Details on termination recommendation.
pub const TerminateRecommendationDetail = struct {
    /// The currency code that Amazon Web Services used to calculate the costs for
    /// this
    /// instance.
    currency_code: ?[]const u8 = null,

    /// The estimated savings that result from modification, on a monthly basis.
    estimated_monthly_savings: ?[]const u8 = null,

    pub const json_field_names = .{
        .currency_code = "CurrencyCode",
        .estimated_monthly_savings = "EstimatedMonthlySavings",
    };
};
