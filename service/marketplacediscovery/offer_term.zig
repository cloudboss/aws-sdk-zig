const ByolPricingTerm = @import("byol_pricing_term.zig").ByolPricingTerm;
const ConfigurableUpfrontPricingTerm = @import("configurable_upfront_pricing_term.zig").ConfigurableUpfrontPricingTerm;
const FixedUpfrontPricingTerm = @import("fixed_upfront_pricing_term.zig").FixedUpfrontPricingTerm;
const FreeTrialPricingTerm = @import("free_trial_pricing_term.zig").FreeTrialPricingTerm;
const LegalTerm = @import("legal_term.zig").LegalTerm;
const NetPaymentTerm = @import("net_payment_term.zig").NetPaymentTerm;
const PaymentScheduleTerm = @import("payment_schedule_term.zig").PaymentScheduleTerm;
const RecurringPaymentTerm = @import("recurring_payment_term.zig").RecurringPaymentTerm;
const RenewalTerm = @import("renewal_term.zig").RenewalTerm;
const SupportTerm = @import("support_term.zig").SupportTerm;
const UsageBasedPricingTerm = @import("usage_based_pricing_term.zig").UsageBasedPricingTerm;
const ValidityTerm = @import("validity_term.zig").ValidityTerm;
const VariablePaymentTerm = @import("variable_payment_term.zig").VariablePaymentTerm;

/// A term attached to an offer. Each element contains exactly one term type,
/// such as a pricing term, legal term, or payment schedule term.
pub const OfferTerm = union(enum) {
    byol_pricing_term: ?ByolPricingTerm,
    configurable_upfront_pricing_term: ?ConfigurableUpfrontPricingTerm,
    fixed_upfront_pricing_term: ?FixedUpfrontPricingTerm,
    free_trial_pricing_term: ?FreeTrialPricingTerm,
    legal_term: ?LegalTerm,
    /// A net payment term.
    net_payment_term: ?NetPaymentTerm,
    payment_schedule_term: ?PaymentScheduleTerm,
    recurring_payment_term: ?RecurringPaymentTerm,
    renewal_term: ?RenewalTerm,
    support_term: ?SupportTerm,
    usage_based_pricing_term: ?UsageBasedPricingTerm,
    validity_term: ?ValidityTerm,
    variable_payment_term: ?VariablePaymentTerm,

    pub const json_field_names = .{
        .byol_pricing_term = "byolPricingTerm",
        .configurable_upfront_pricing_term = "configurableUpfrontPricingTerm",
        .fixed_upfront_pricing_term = "fixedUpfrontPricingTerm",
        .free_trial_pricing_term = "freeTrialPricingTerm",
        .legal_term = "legalTerm",
        .net_payment_term = "netPaymentTerm",
        .payment_schedule_term = "paymentScheduleTerm",
        .recurring_payment_term = "recurringPaymentTerm",
        .renewal_term = "renewalTerm",
        .support_term = "supportTerm",
        .usage_based_pricing_term = "usageBasedPricingTerm",
        .validity_term = "validityTerm",
        .variable_payment_term = "variablePaymentTerm",
    };
};
