const AccountScope = @import("account_scope.zig").AccountScope;
const LookbackPeriodInDays = @import("lookback_period_in_days.zig").LookbackPeriodInDays;
const PaymentOption = @import("payment_option.zig").PaymentOption;
const SavingsPlansPurchaseRecommendationDetail = @import("savings_plans_purchase_recommendation_detail.zig").SavingsPlansPurchaseRecommendationDetail;
const SavingsPlansPurchaseRecommendationSummary = @import("savings_plans_purchase_recommendation_summary.zig").SavingsPlansPurchaseRecommendationSummary;
const SupportedSavingsPlansType = @import("supported_savings_plans_type.zig").SupportedSavingsPlansType;
const TermInYears = @import("term_in_years.zig").TermInYears;

/// Contains your request parameters, Savings Plan Recommendations Summary, and
/// Details.
pub const SavingsPlansPurchaseRecommendation = struct {
    /// The account scope that you want your recommendations for. Amazon Web
    /// Services
    /// calculates recommendations that include the management account and member
    /// accounts if
    /// the value is set to `PAYER`. If the value is `LINKED`,
    /// recommendations are calculated for individual member accounts only.
    account_scope: ?AccountScope,

    /// The lookback period in days that's used to generate the recommendation.
    lookback_period_in_days: ?LookbackPeriodInDays,

    /// The payment option that's used to generate the recommendation.
    payment_option: ?PaymentOption,

    /// Details for the Savings Plans that we recommend that you purchase to cover
    /// existing
    /// Savings Plans eligible workloads.
    savings_plans_purchase_recommendation_details: ?[]const SavingsPlansPurchaseRecommendationDetail,

    /// Summary metrics for your Savings Plans Recommendations.
    savings_plans_purchase_recommendation_summary: ?SavingsPlansPurchaseRecommendationSummary,

    /// The requested Savings Plans recommendation type.
    savings_plans_type: ?SupportedSavingsPlansType,

    /// The Savings Plans recommendation term in years. It's used to generate the
    /// recommendation.
    term_in_years: ?TermInYears,

    pub const json_field_names = .{
        .account_scope = "AccountScope",
        .lookback_period_in_days = "LookbackPeriodInDays",
        .payment_option = "PaymentOption",
        .savings_plans_purchase_recommendation_details = "SavingsPlansPurchaseRecommendationDetails",
        .savings_plans_purchase_recommendation_summary = "SavingsPlansPurchaseRecommendationSummary",
        .savings_plans_type = "SavingsPlansType",
        .term_in_years = "TermInYears",
    };
};
