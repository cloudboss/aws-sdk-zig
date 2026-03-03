const SavingsPlansDetails = @import("savings_plans_details.zig").SavingsPlansDetails;

/// Details for your recommended Savings Plans.
pub const SavingsPlansPurchaseRecommendationDetail = struct {
    /// The `AccountID` the recommendation is generated for.
    account_id: ?[]const u8 = null,

    /// The currency code that Amazon Web Services used to generate the
    /// recommendations and
    /// present potential savings.
    currency_code: ?[]const u8 = null,

    /// The average value of hourly On-Demand spend over the lookback period of the
    /// applicable
    /// usage type.
    current_average_hourly_on_demand_spend: ?[]const u8 = null,

    /// The highest value of hourly On-Demand spend over the lookback period of the
    /// applicable
    /// usage type.
    current_maximum_hourly_on_demand_spend: ?[]const u8 = null,

    /// The lowest value of hourly On-Demand spend over the lookback period of the
    /// applicable
    /// usage type.
    current_minimum_hourly_on_demand_spend: ?[]const u8 = null,

    /// The estimated utilization of the recommended Savings Plans.
    estimated_average_utilization: ?[]const u8 = null,

    /// The estimated monthly savings amount based on the recommended Savings Plans.
    estimated_monthly_savings_amount: ?[]const u8 = null,

    /// The remaining On-Demand cost estimated to not be covered by the recommended
    /// Savings
    /// Plans, over the length of the lookback period.
    estimated_on_demand_cost: ?[]const u8 = null,

    /// The estimated On-Demand costs you expect with no additional commitment,
    /// based on your
    /// usage of the selected time period and the Savings Plans you own.
    estimated_on_demand_cost_with_current_commitment: ?[]const u8 = null,

    /// The estimated return on investment that's based on the recommended Savings
    /// Plans that
    /// you purchased. This is calculated as `estimatedSavingsAmount`/
    /// `estimatedSPCost`*100.
    estimated_roi: ?[]const u8 = null,

    /// The estimated savings amount that's based on the recommended Savings Plans
    /// over the
    /// length of the lookback period.
    estimated_savings_amount: ?[]const u8 = null,

    /// The estimated savings percentage relative to the total cost of applicable
    /// On-Demand
    /// usage over the lookback period.
    estimated_savings_percentage: ?[]const u8 = null,

    /// The cost of the recommended Savings Plans over the length of the lookback
    /// period.
    estimated_sp_cost: ?[]const u8 = null,

    /// The recommended hourly commitment level for the Savings Plans type and the
    /// configuration that's based on the usage during the lookback period.
    hourly_commitment_to_purchase: ?[]const u8 = null,

    /// Contains detailed information about a specific Savings Plan recommendation.
    recommendation_detail_id: ?[]const u8 = null,

    /// Details for your recommended Savings Plans.
    savings_plans_details: ?SavingsPlansDetails = null,

    /// The upfront cost of the recommended Savings Plans, based on the selected
    /// payment
    /// option.
    upfront_cost: ?[]const u8 = null,

    pub const json_field_names = .{
        .account_id = "AccountId",
        .currency_code = "CurrencyCode",
        .current_average_hourly_on_demand_spend = "CurrentAverageHourlyOnDemandSpend",
        .current_maximum_hourly_on_demand_spend = "CurrentMaximumHourlyOnDemandSpend",
        .current_minimum_hourly_on_demand_spend = "CurrentMinimumHourlyOnDemandSpend",
        .estimated_average_utilization = "EstimatedAverageUtilization",
        .estimated_monthly_savings_amount = "EstimatedMonthlySavingsAmount",
        .estimated_on_demand_cost = "EstimatedOnDemandCost",
        .estimated_on_demand_cost_with_current_commitment = "EstimatedOnDemandCostWithCurrentCommitment",
        .estimated_roi = "EstimatedROI",
        .estimated_savings_amount = "EstimatedSavingsAmount",
        .estimated_savings_percentage = "EstimatedSavingsPercentage",
        .estimated_sp_cost = "EstimatedSPCost",
        .hourly_commitment_to_purchase = "HourlyCommitmentToPurchase",
        .recommendation_detail_id = "RecommendationDetailId",
        .savings_plans_details = "SavingsPlansDetails",
        .upfront_cost = "UpfrontCost",
    };
};
