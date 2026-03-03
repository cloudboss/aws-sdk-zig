const LegalTerm = @import("legal_term.zig").LegalTerm;
const SupportTerm = @import("support_term.zig").SupportTerm;
const PricingTerm = @import("pricing_term.zig").PricingTerm;
const ValidityTerm = @import("validity_term.zig").ValidityTerm;

/// Describes the usage terms of an offer.
pub const TermDetails = struct {
    /// Describes the legal terms.
    legal_term: LegalTerm,

    /// Describes the support terms.
    support_term: SupportTerm,

    usage_based_pricing_term: PricingTerm,

    /// Describes the validity terms.
    validity_term: ?ValidityTerm = null,

    pub const json_field_names = .{
        .legal_term = "legalTerm",
        .support_term = "supportTerm",
        .usage_based_pricing_term = "usageBasedPricingTerm",
        .validity_term = "validityTerm",
    };
};
