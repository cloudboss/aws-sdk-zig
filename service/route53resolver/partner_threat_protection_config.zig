/// The configuration for a partner threat-protection rule. To enumerate the
/// partners available in your account, call ListFirewallRuleTypes with
/// `RuleType` set to `PartnerThreatProtection` — each returned
/// FirewallRuleTypeDefinition includes a SubscriptionInfo identifying the
/// Amazon Web Services Marketplace product that backs it.
pub const PartnerThreatProtectionConfig = struct {
    /// The identifier of the partner threat-protection product, exactly as returned
    /// in the `Value` field of a FirewallRuleTypeDefinition with `RuleType` set to
    /// `PartnerThreatProtection`. The calling account must hold an active Amazon
    /// Web Services Marketplace subscription to this product.
    partner: []const u8,

    pub const json_field_names = .{
        .partner = "Partner",
    };
};
