const DnsThreatProtectionRuleTypeConfig = @import("dns_threat_protection_rule_type_config.zig").DnsThreatProtectionRuleTypeConfig;
const FirewallAdvancedContentCategoryConfig = @import("firewall_advanced_content_category_config.zig").FirewallAdvancedContentCategoryConfig;
const FirewallAdvancedThreatCategoryConfig = @import("firewall_advanced_threat_category_config.zig").FirewallAdvancedThreatCategoryConfig;
const PartnerThreatProtectionConfig = @import("partner_threat_protection_config.zig").PartnerThreatProtectionConfig;

/// The rule-type configuration for a DNS Firewall rule. `FirewallRuleType` is a
/// tagged union — exactly one member must be set per rule, and the member
/// determines what the rule matches against. This shape is mutually exclusive
/// with the top-level `FirewallDomainListId` and `DnsThreatProtection` fields
/// on CreateFirewallRule and UpdateFirewallRule.
///
/// Call ListFirewallRuleTypes to discover which rule-type variants and which
/// values within each variant are available in your account and Region.
pub const FirewallRuleType = struct {
    /// Configures the rule to match a built-in DNS Firewall Advanced threat
    /// detector — `DGA`, `DNS_TUNNELING`, or `DICTIONARY_DGA`. See
    /// DnsThreatProtectionRuleTypeConfig.
    dns_threat_protection: ?DnsThreatProtectionRuleTypeConfig = null,

    /// Configures the rule to match an Amazon Web Services-managed content category
    /// (for example, `VIOLENCE_AND_HATE_SPEECH`). See
    /// FirewallAdvancedContentCategoryConfig.
    firewall_advanced_content_category: ?FirewallAdvancedContentCategoryConfig = null,

    /// Configures the rule to match an Amazon Web Services-managed advanced threat
    /// category (for example, `PHISHING`). See
    /// FirewallAdvancedThreatCategoryConfig.
    firewall_advanced_threat_category: ?FirewallAdvancedThreatCategoryConfig = null,

    /// Configures the rule to match a third-party threat feed delivered through
    /// Amazon Web Services Marketplace. The calling account must hold an active
    /// subscription to the partner product named in `Partner`; if the subscription
    /// is missing or revoked, the rule is created with `Status`
    /// `CREATION_FAILED` and cannot be modified — only deleted. See
    /// PartnerThreatProtectionConfig.
    partner_threat_protection: ?PartnerThreatProtectionConfig = null,

    pub const json_field_names = .{
        .dns_threat_protection = "DnsThreatProtection",
        .firewall_advanced_content_category = "FirewallAdvancedContentCategory",
        .firewall_advanced_threat_category = "FirewallAdvancedThreatCategory",
        .partner_threat_protection = "PartnerThreatProtection",
    };
};
