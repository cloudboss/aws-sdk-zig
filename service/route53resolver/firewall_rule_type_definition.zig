const SubscriptionInfo = @import("subscription_info.zig").SubscriptionInfo;

/// The definition of an available rule type that can be used in DNS Firewall
/// rules. This is returned by ListFirewallRuleTypes.
pub const FirewallRuleTypeDefinition = struct {
    /// A description of the rule type.
    description: ?[]const u8 = null,

    /// The display name of the rule type.
    display_name: ?[]const u8 = null,

    /// The category or class of the rule type, such as
    /// `FirewallAdvancedContentCategory` or `FirewallAdvancedThreatCategory`.
    rule_type: ?[]const u8 = null,

    /// For rule types that require an external subscription (today, only the
    /// `PartnerThreatProtection` variant), describes the Amazon Web Services
    /// Marketplace product that backs the rule type. Absent for rule types that are
    /// managed by Amazon Web Services and do not require a separate subscription.
    /// See SubscriptionInfo.
    subscription_info: ?SubscriptionInfo = null,

    /// The specific identifier within the rule type category, such as
    /// `VIOLENCE_AND_HATE_SPEECH` or `PHISHING`.
    value: ?[]const u8 = null,

    pub const json_field_names = .{
        .description = "Description",
        .display_name = "DisplayName",
        .rule_type = "RuleType",
        .subscription_info = "SubscriptionInfo",
        .value = "Value",
    };
};
