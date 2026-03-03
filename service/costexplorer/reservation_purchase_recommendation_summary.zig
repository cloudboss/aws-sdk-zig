/// A summary about this recommendation, such as the currency code, the amount
/// that
/// Amazon Web Services estimates that you could save, and the total amount of
/// reservation to purchase.
pub const ReservationPurchaseRecommendationSummary = struct {
    /// The currency code used for this recommendation.
    currency_code: ?[]const u8 = null,

    /// The total amount that Amazon Web Services estimates that this recommendation
    /// could save
    /// you in a month.
    total_estimated_monthly_savings_amount: ?[]const u8 = null,

    /// The total amount that Amazon Web Services estimates that this recommendation
    /// could save
    /// you in a month, as a percentage of your costs.
    total_estimated_monthly_savings_percentage: ?[]const u8 = null,

    pub const json_field_names = .{
        .currency_code = "CurrencyCode",
        .total_estimated_monthly_savings_amount = "TotalEstimatedMonthlySavingsAmount",
        .total_estimated_monthly_savings_percentage = "TotalEstimatedMonthlySavingsPercentage",
    };
};
