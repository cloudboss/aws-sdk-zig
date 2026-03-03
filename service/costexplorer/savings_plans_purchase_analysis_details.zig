const RecommendationDetailHourlyMetrics = @import("recommendation_detail_hourly_metrics.zig").RecommendationDetailHourlyMetrics;

/// Details about the Savings Plans purchase analysis.
pub const SavingsPlansPurchaseAnalysisDetails = struct {
    /// Additional metadata that might be applicable to the commitment.
    additional_metadata: ?[]const u8 = null,

    /// The currency code used for the analysis.
    currency_code: ?[]const u8 = null,

    /// The average value of hourly coverage over the lookback period.
    current_average_coverage: ?[]const u8 = null,

    /// The average value of hourly On-Demand spend over the lookback period.
    current_average_hourly_on_demand_spend: ?[]const u8 = null,

    /// The highest value of hourly On-Demand spend over the lookback period.
    current_maximum_hourly_on_demand_spend: ?[]const u8 = null,

    /// The lowest value of hourly On-Demand spend over the lookback period.
    current_minimum_hourly_on_demand_spend: ?[]const u8 = null,

    /// The current total On-Demand spend over the lookback period.
    current_on_demand_spend: ?[]const u8 = null,

    /// The estimated coverage of the Savings Plan.
    estimated_average_coverage: ?[]const u8 = null,

    /// The estimated utilization of the Savings Plan.
    estimated_average_utilization: ?[]const u8 = null,

    /// The estimated cost of the Savings Plan over the length of the lookback
    /// period.
    estimated_commitment_cost: ?[]const u8 = null,

    /// The estimated monthly savings amount based on the Savings Plan.
    estimated_monthly_savings_amount: ?[]const u8 = null,

    /// The remaining On-Demand cost estimated to not be covered by the Savings Plan
    /// over the
    /// length of the lookback period.
    estimated_on_demand_cost: ?[]const u8 = null,

    /// The estimated On-Demand cost you expect with no additional commitment based
    /// on your
    /// usage of the selected time period and the Savings Plan you own.
    estimated_on_demand_cost_with_current_commitment: ?[]const u8 = null,

    /// The estimated return on investment that's based on the Savings Plan and
    /// estimated
    /// savings. This is calculated as estimatedSavingsAmount/estimatedSPCost*100.
    estimated_roi: ?[]const u8 = null,

    /// The estimated savings amount that's based on the Savings Plan over the
    /// length of the
    /// lookback period.
    estimated_savings_amount: ?[]const u8 = null,

    /// The estimated savings percentage relative to the total cost over the cost
    /// calculation
    /// lookback period.
    estimated_savings_percentage: ?[]const u8 = null,

    /// The existing hourly commitment for the Savings Plan type.
    existing_hourly_commitment: ?[]const u8 = null,

    /// The recommended or custom hourly commitment.
    hourly_commitment_to_purchase: ?[]const u8 = null,

    /// The date and time of the last hour that went into the analysis.
    latest_usage_timestamp: ?[]const u8 = null,

    /// The lookback period in hours that's used to generate the analysis.
    lookback_period_in_hours: ?[]const u8 = null,

    /// The related hourly cost, coverage, and utilization metrics over the lookback
    /// period.
    metrics_over_lookback_period: ?[]const RecommendationDetailHourlyMetrics = null,

    /// The upfront cost of the Savings Plan based on the selected payment option.
    upfront_cost: ?[]const u8 = null,

    pub const json_field_names = .{
        .additional_metadata = "AdditionalMetadata",
        .currency_code = "CurrencyCode",
        .current_average_coverage = "CurrentAverageCoverage",
        .current_average_hourly_on_demand_spend = "CurrentAverageHourlyOnDemandSpend",
        .current_maximum_hourly_on_demand_spend = "CurrentMaximumHourlyOnDemandSpend",
        .current_minimum_hourly_on_demand_spend = "CurrentMinimumHourlyOnDemandSpend",
        .current_on_demand_spend = "CurrentOnDemandSpend",
        .estimated_average_coverage = "EstimatedAverageCoverage",
        .estimated_average_utilization = "EstimatedAverageUtilization",
        .estimated_commitment_cost = "EstimatedCommitmentCost",
        .estimated_monthly_savings_amount = "EstimatedMonthlySavingsAmount",
        .estimated_on_demand_cost = "EstimatedOnDemandCost",
        .estimated_on_demand_cost_with_current_commitment = "EstimatedOnDemandCostWithCurrentCommitment",
        .estimated_roi = "EstimatedROI",
        .estimated_savings_amount = "EstimatedSavingsAmount",
        .estimated_savings_percentage = "EstimatedSavingsPercentage",
        .existing_hourly_commitment = "ExistingHourlyCommitment",
        .hourly_commitment_to_purchase = "HourlyCommitmentToPurchase",
        .latest_usage_timestamp = "LatestUsageTimestamp",
        .lookback_period_in_hours = "LookbackPeriodInHours",
        .metrics_over_lookback_period = "MetricsOverLookbackPeriod",
        .upfront_cost = "UpfrontCost",
    };
};
