/// The summary of rightsizing recommendations
pub const RightsizingRecommendationSummary = struct {
    /// The estimated total savings resulting from modifications, on a monthly
    /// basis.
    estimated_total_monthly_savings_amount: ?[]const u8,

    /// The currency code that Amazon Web Services used to calculate the savings.
    savings_currency_code: ?[]const u8,

    /// The savings percentage based on the recommended modifications. It's relative
    /// to the
    /// total On-Demand costs that are associated with these instances.
    savings_percentage: ?[]const u8,

    /// The total number of instance recommendations.
    total_recommendation_count: ?[]const u8,

    pub const json_field_names = .{
        .estimated_total_monthly_savings_amount = "EstimatedTotalMonthlySavingsAmount",
        .savings_currency_code = "SavingsCurrencyCode",
        .savings_percentage = "SavingsPercentage",
        .total_recommendation_count = "TotalRecommendationCount",
    };
};
