/// Summary metrics for your Savings Plans Purchase Recommendations.
pub const SavingsPlansPurchaseRecommendationSummary = struct {
    /// The currency code that Amazon Web Services used to generate the
    /// recommendations and
    /// present potential savings.
    currency_code: ?[]const u8 = null,

    /// The current total on demand spend of the applicable usage types over the
    /// lookback
    /// period.
    current_on_demand_spend: ?[]const u8 = null,

    /// The recommended Savings Plans cost on a daily (24 hourly) basis.
    daily_commitment_to_purchase: ?[]const u8 = null,

    /// The estimated monthly savings amount that's based on the recommended Savings
    /// Plans
    /// purchase.
    estimated_monthly_savings_amount: ?[]const u8 = null,

    /// The estimated On-Demand costs you expect with no additional commitment. It's
    /// based on
    /// your usage of the selected time period and the Savings Plans you own.
    estimated_on_demand_cost_with_current_commitment: ?[]const u8 = null,

    /// The estimated return on investment that's based on the recommended Savings
    /// Plans and
    /// estimated savings.
    estimated_roi: ?[]const u8 = null,

    /// The estimated total savings over the lookback period, based on the purchase
    /// of the
    /// recommended Savings Plans.
    estimated_savings_amount: ?[]const u8 = null,

    /// The estimated savings relative to the total cost of On-Demand usage, over
    /// the lookback
    /// period. This is calculated as `estimatedSavingsAmount`/
    /// `CurrentOnDemandSpend`*100.
    estimated_savings_percentage: ?[]const u8 = null,

    /// The estimated total cost of the usage after purchasing the recommended
    /// Savings Plans.
    /// This is a sum of the cost of Savings Plans during this term, and the
    /// remaining On-Demand
    /// usage.
    estimated_total_cost: ?[]const u8 = null,

    /// The recommended hourly commitment that's based on the recommendation
    /// parameters.
    hourly_commitment_to_purchase: ?[]const u8 = null,

    /// The aggregate number of Savings Plans recommendations that exist for your
    /// account.
    total_recommendation_count: ?[]const u8 = null,

    pub const json_field_names = .{
        .currency_code = "CurrencyCode",
        .current_on_demand_spend = "CurrentOnDemandSpend",
        .daily_commitment_to_purchase = "DailyCommitmentToPurchase",
        .estimated_monthly_savings_amount = "EstimatedMonthlySavingsAmount",
        .estimated_on_demand_cost_with_current_commitment = "EstimatedOnDemandCostWithCurrentCommitment",
        .estimated_roi = "EstimatedROI",
        .estimated_savings_amount = "EstimatedSavingsAmount",
        .estimated_savings_percentage = "EstimatedSavingsPercentage",
        .estimated_total_cost = "EstimatedTotalCost",
        .hourly_commitment_to_purchase = "HourlyCommitmentToPurchase",
        .total_recommendation_count = "TotalRecommendationCount",
    };
};
