const AccountScope = @import("account_scope.zig").AccountScope;
const LookbackPeriodInDays = @import("lookback_period_in_days.zig").LookbackPeriodInDays;
const RecommendationDetailHourlyMetrics = @import("recommendation_detail_hourly_metrics.zig").RecommendationDetailHourlyMetrics;
const PaymentOption = @import("payment_option.zig").PaymentOption;
const SupportedSavingsPlansType = @import("supported_savings_plans_type.zig").SupportedSavingsPlansType;
const TermInYears = @import("term_in_years.zig").TermInYears;

/// The details and metrics for the given recommendation.
pub const RecommendationDetailData = struct {
    /// The AccountID that the recommendation is generated for.
    account_id: ?[]const u8,

    /// The account scope that you want your recommendations for. Amazon Web
    /// Services
    /// calculates recommendations including the management account and member
    /// accounts if the
    /// value is set to PAYER. If the value is LINKED, recommendations are
    /// calculated for
    /// individual member accounts only.
    account_scope: ?AccountScope,

    /// The currency code that Amazon Web Services used to generate the
    /// recommendation and
    /// present potential savings.
    currency_code: ?[]const u8,

    /// The average value of hourly coverage over the lookback period.
    current_average_coverage: ?[]const u8,

    /// The average value of hourly On-Demand spend over the lookback period of the
    /// applicable
    /// usage type.
    current_average_hourly_on_demand_spend: ?[]const u8,

    /// The highest value of hourly On-Demand spend over the lookback period of the
    /// applicable
    /// usage type.
    current_maximum_hourly_on_demand_spend: ?[]const u8,

    /// The lowest value of hourly On-Demand spend over the lookback period of the
    /// applicable
    /// usage type.
    current_minimum_hourly_on_demand_spend: ?[]const u8,

    /// The estimated coverage of the recommended Savings Plan.
    estimated_average_coverage: ?[]const u8,

    /// The estimated utilization of the recommended Savings Plan.
    estimated_average_utilization: ?[]const u8,

    /// The estimated monthly savings amount based on the recommended Savings Plan.
    estimated_monthly_savings_amount: ?[]const u8,

    /// The remaining On-Demand cost estimated to not be covered by the recommended
    /// Savings
    /// Plan, over the length of the lookback period.
    estimated_on_demand_cost: ?[]const u8,

    /// The estimated On-Demand costs you expect with no additional commitment,
    /// based on your
    /// usage of the selected time period and the Savings Plan you own.
    estimated_on_demand_cost_with_current_commitment: ?[]const u8,

    /// The estimated return on investment that's based on the recommended Savings
    /// Plan that
    /// you purchased. This is calculated as
    /// estimatedSavingsAmount/estimatedSPCost*100.
    estimated_roi: ?[]const u8,

    /// The estimated savings amount that's based on the recommended Savings Plan
    /// over the
    /// length of the lookback period.
    estimated_savings_amount: ?[]const u8,

    /// The estimated savings percentage relative to the total cost of applicable
    /// On-Demand
    /// usage over the lookback period.
    estimated_savings_percentage: ?[]const u8,

    /// The cost of the recommended Savings Plan over the length of the lookback
    /// period.
    estimated_sp_cost: ?[]const u8,

    /// The existing hourly commitment for the Savings Plan type.
    existing_hourly_commitment: ?[]const u8,

    generation_timestamp: ?[]const u8,

    /// The recommended hourly commitment level for the Savings Plan type and the
    /// configuration that's based on the usage during the lookback period.
    hourly_commitment_to_purchase: ?[]const u8,

    /// The instance family of the recommended Savings Plan.
    instance_family: ?[]const u8,

    latest_usage_timestamp: ?[]const u8,

    /// How many days of previous usage that Amazon Web Services considers when
    /// making this
    /// recommendation.
    lookback_period_in_days: ?LookbackPeriodInDays,

    /// The related hourly cost, coverage, and utilization metrics over the lookback
    /// period.
    metrics_over_lookback_period: ?[]const RecommendationDetailHourlyMetrics,

    /// The unique ID that's used to distinguish Savings Plans from one another.
    offering_id: ?[]const u8,

    /// The payment option for the commitment (for example, All Upfront or No
    /// Upfront).
    payment_option: ?PaymentOption,

    /// The region the recommendation is generated for.
    region: ?[]const u8,

    /// The requested Savings Plan recommendation type.
    savings_plans_type: ?SupportedSavingsPlansType,

    /// The term of the commitment in years.
    term_in_years: ?TermInYears,

    /// The upfront cost of the recommended Savings Plan, based on the selected
    /// payment
    /// option.
    upfront_cost: ?[]const u8,

    pub const json_field_names = .{
        .account_id = "AccountId",
        .account_scope = "AccountScope",
        .currency_code = "CurrencyCode",
        .current_average_coverage = "CurrentAverageCoverage",
        .current_average_hourly_on_demand_spend = "CurrentAverageHourlyOnDemandSpend",
        .current_maximum_hourly_on_demand_spend = "CurrentMaximumHourlyOnDemandSpend",
        .current_minimum_hourly_on_demand_spend = "CurrentMinimumHourlyOnDemandSpend",
        .estimated_average_coverage = "EstimatedAverageCoverage",
        .estimated_average_utilization = "EstimatedAverageUtilization",
        .estimated_monthly_savings_amount = "EstimatedMonthlySavingsAmount",
        .estimated_on_demand_cost = "EstimatedOnDemandCost",
        .estimated_on_demand_cost_with_current_commitment = "EstimatedOnDemandCostWithCurrentCommitment",
        .estimated_roi = "EstimatedROI",
        .estimated_savings_amount = "EstimatedSavingsAmount",
        .estimated_savings_percentage = "EstimatedSavingsPercentage",
        .estimated_sp_cost = "EstimatedSPCost",
        .existing_hourly_commitment = "ExistingHourlyCommitment",
        .generation_timestamp = "GenerationTimestamp",
        .hourly_commitment_to_purchase = "HourlyCommitmentToPurchase",
        .instance_family = "InstanceFamily",
        .latest_usage_timestamp = "LatestUsageTimestamp",
        .lookback_period_in_days = "LookbackPeriodInDays",
        .metrics_over_lookback_period = "MetricsOverLookbackPeriod",
        .offering_id = "OfferingId",
        .payment_option = "PaymentOption",
        .region = "Region",
        .savings_plans_type = "SavingsPlansType",
        .term_in_years = "TermInYears",
        .upfront_cost = "UpfrontCost",
    };
};
