const AccountScope = @import("account_scope.zig").AccountScope;
const LookbackPeriodInDays = @import("lookback_period_in_days.zig").LookbackPeriodInDays;
const PaymentOption = @import("payment_option.zig").PaymentOption;
const ReservationPurchaseRecommendationDetail = @import("reservation_purchase_recommendation_detail.zig").ReservationPurchaseRecommendationDetail;
const ReservationPurchaseRecommendationSummary = @import("reservation_purchase_recommendation_summary.zig").ReservationPurchaseRecommendationSummary;
const ServiceSpecification = @import("service_specification.zig").ServiceSpecification;
const TermInYears = @import("term_in_years.zig").TermInYears;

/// A specific reservation that Amazon Web Services recommends for purchase.
pub const ReservationPurchaseRecommendation = struct {
    /// The account scope that Amazon Web Services recommends that you purchase this
    /// instance
    /// for. For example, you can purchase this reservation for an entire
    /// organization in
    /// Amazon Web Services Organizations.
    account_scope: ?AccountScope = null,

    /// How many days of previous usage that Amazon Web Services considers when
    /// making this
    /// recommendation.
    lookback_period_in_days: ?LookbackPeriodInDays = null,

    /// The payment option for the reservation (for example, `AllUpfront` or
    /// `NoUpfront`).
    payment_option: ?PaymentOption = null,

    /// Details about the recommended purchases.
    recommendation_details: ?[]const ReservationPurchaseRecommendationDetail = null,

    /// A summary about the recommended purchase.
    recommendation_summary: ?ReservationPurchaseRecommendationSummary = null,

    /// Hardware specifications for the service that you want recommendations for.
    service_specification: ?ServiceSpecification = null,

    /// The term of the reservation that you want recommendations for, in years.
    term_in_years: ?TermInYears = null,

    pub const json_field_names = .{
        .account_scope = "AccountScope",
        .lookback_period_in_days = "LookbackPeriodInDays",
        .payment_option = "PaymentOption",
        .recommendation_details = "RecommendationDetails",
        .recommendation_summary = "RecommendationSummary",
        .service_specification = "ServiceSpecification",
        .term_in_years = "TermInYears",
    };
};
