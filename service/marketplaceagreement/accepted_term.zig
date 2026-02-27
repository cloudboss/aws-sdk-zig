const ByolPricingTerm = @import("byol_pricing_term.zig").ByolPricingTerm;
const ConfigurableUpfrontPricingTerm = @import("configurable_upfront_pricing_term.zig").ConfigurableUpfrontPricingTerm;
const FixedUpfrontPricingTerm = @import("fixed_upfront_pricing_term.zig").FixedUpfrontPricingTerm;
const FreeTrialPricingTerm = @import("free_trial_pricing_term.zig").FreeTrialPricingTerm;
const LegalTerm = @import("legal_term.zig").LegalTerm;
const PaymentScheduleTerm = @import("payment_schedule_term.zig").PaymentScheduleTerm;
const RecurringPaymentTerm = @import("recurring_payment_term.zig").RecurringPaymentTerm;
const RenewalTerm = @import("renewal_term.zig").RenewalTerm;
const SupportTerm = @import("support_term.zig").SupportTerm;
const UsageBasedPricingTerm = @import("usage_based_pricing_term.zig").UsageBasedPricingTerm;
const ValidityTerm = @import("validity_term.zig").ValidityTerm;
const VariablePaymentTerm = @import("variable_payment_term.zig").VariablePaymentTerm;

/// A subset of terms proposed by the proposer, which have been accepted by the
/// acceptor as part of agreement creation.
pub const AcceptedTerm = union(enum) {
    /// Enables you and your customers to move your existing agreements to AWS
    /// Marketplace. The customer won't be charged for product usage in AWS
    /// Marketplace because they already paid for the product outside of AWS
    /// Marketplace.
    byol_pricing_term: ?ByolPricingTerm,
    /// Defines a prepaid payment model that allows buyers to configure the
    /// entitlements they want to purchase and the duration.
    configurable_upfront_pricing_term: ?ConfigurableUpfrontPricingTerm,
    /// Defines a pre-paid pricing model where the customers are charged a fixed
    /// upfront amount.
    fixed_upfront_pricing_term: ?FixedUpfrontPricingTerm,
    /// Defines a short-term free pricing model where the buyers aren’t charged
    /// anything within a specified limit.
    free_trial_pricing_term: ?FreeTrialPricingTerm,
    /// Defines the list of text agreements proposed to the acceptors. An example is
    /// the end user license agreement (EULA).
    legal_term: ?LegalTerm,
    /// Defines an installment-based pricing model where customers are charged a
    /// fixed price on different dates during the agreement validity period. This is
    /// used most commonly for flexible payment schedule pricing.
    payment_schedule_term: ?PaymentScheduleTerm,
    /// Defines a pricing model where customers are charged a fixed recurring price
    /// at the end of each billing period.
    recurring_payment_term: ?RecurringPaymentTerm,
    /// Defines that on graceful expiration of the agreement (when the agreement
    /// ends on its pre-defined end date), a new agreement will be created using the
    /// accepted terms on the existing agreement. In other words, the agreement will
    /// be renewed. Presence of `RenewalTerm` in the offer document means that
    /// auto-renewal is allowed. Buyers will have the option to accept or decline
    /// auto-renewal at the offer acceptance/agreement creation. Buyers can also
    /// change this flag from `True` to `False` or `False` to `True` at anytime
    /// during the agreement's lifecycle.
    renewal_term: ?RenewalTerm,
    /// Defines the customer support available for the acceptors when they purchase
    /// the software.
    support_term: ?SupportTerm,
    /// Defines a usage-based pricing model (typically, pay-as-you-go pricing),
    /// where the customers are charged based on product usage.
    usage_based_pricing_term: ?UsageBasedPricingTerm,
    /// Defines the conditions that will keep an agreement created from this offer
    /// valid.
    validity_term: ?ValidityTerm,
    /// Defines a payment model where sellers can submit variable payment requests
    /// up to a maximum charge amount, with configurable approval strategies and
    /// expiration timelines.
    variable_payment_term: ?VariablePaymentTerm,

    pub const json_field_names = .{
        .byol_pricing_term = "byolPricingTerm",
        .configurable_upfront_pricing_term = "configurableUpfrontPricingTerm",
        .fixed_upfront_pricing_term = "fixedUpfrontPricingTerm",
        .free_trial_pricing_term = "freeTrialPricingTerm",
        .legal_term = "legalTerm",
        .payment_schedule_term = "paymentScheduleTerm",
        .recurring_payment_term = "recurringPaymentTerm",
        .renewal_term = "renewalTerm",
        .support_term = "supportTerm",
        .usage_based_pricing_term = "usageBasedPricingTerm",
        .validity_term = "validityTerm",
        .variable_payment_term = "variablePaymentTerm",
    };
};
