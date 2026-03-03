const ExcludedRule = @import("excluded_rule.zig").ExcludedRule;
const ManagedRuleGroupConfig = @import("managed_rule_group_config.zig").ManagedRuleGroupConfig;
const RuleActionOverride = @import("rule_action_override.zig").RuleActionOverride;
const Statement = @import("statement.zig").Statement;

/// A rule statement used to run the rules that are defined in a managed rule
/// group. To use this, provide the vendor name and the name of the rule group
/// in this statement. You can retrieve the required names by calling
/// ListAvailableManagedRuleGroups.
///
/// You cannot nest a `ManagedRuleGroupStatement`, for example for use inside a
/// `NotStatement` or `OrStatement`. You cannot use a managed rule group
/// inside another rule group. You can only reference a managed rule group as a
/// top-level statement within a rule that you define in a web ACL.
///
/// You are charged additional fees when you use the WAF Bot Control managed
/// rule group `AWSManagedRulesBotControlRuleSet`, the WAF Fraud Control account
/// takeover prevention (ATP) managed rule group `AWSManagedRulesATPRuleSet`, or
/// the WAF Fraud Control account creation fraud prevention (ACFP) managed rule
/// group `AWSManagedRulesACFPRuleSet`. For more information, see [WAF
/// Pricing](http://aws.amazon.com/waf/pricing/).
pub const ManagedRuleGroupStatement = struct {
    /// Rules in the referenced rule group whose actions are set to `Count`.
    ///
    /// Instead of this option, use `RuleActionOverrides`. It accepts any valid
    /// action setting, including `Count`.
    excluded_rules: ?[]const ExcludedRule = null,

    /// Additional information that's used by a managed rule group. Many managed
    /// rule groups don't require this.
    ///
    /// The rule groups used for intelligent threat mitigation require additional
    /// configuration:
    ///
    /// * Use the `AWSManagedRulesACFPRuleSet` configuration object to configure the
    ///   account creation fraud prevention managed rule group. The configuration
    ///   includes the registration and sign-up pages of your application and the
    ///   locations in the account creation request payload of data, such as the
    ///   user email and phone number fields.
    ///
    /// * Use the `AWSManagedRulesAntiDDoSRuleSet` configuration object to configure
    ///   the anti-DDoS managed rule group. The configuration includes the
    ///   sensitivity levels to use in the rules that typically block and challenge
    ///   requests that might be participating in DDoS attacks and the specification
    ///   to use to indicate whether a request can handle a silent browser
    ///   challenge.
    ///
    /// * Use the `AWSManagedRulesATPRuleSet` configuration object to configure the
    ///   account takeover prevention managed rule group. The configuration includes
    ///   the sign-in page of your application and the locations in the login
    ///   request payload of data such as the username and password.
    ///
    /// * Use the `AWSManagedRulesBotControlRuleSet` configuration object to
    ///   configure the
    /// protection level that you want the Bot Control rule group to use.
    managed_rule_group_configs: ?[]const ManagedRuleGroupConfig = null,

    /// The name of the managed rule group. You use this, along with the vendor
    /// name, to identify the rule group.
    name: []const u8,

    /// Action settings to use in the place of the rule actions that are configured
    /// inside the rule group. You specify one override for each rule whose action
    /// you want to change.
    ///
    /// Verify the rule names in your overrides carefully. With managed rule groups,
    /// WAF silently ignores any override that uses an invalid rule name. With
    /// customer-owned rule groups, invalid rule names in your overrides will cause
    /// web ACL updates to fail. An invalid rule name is any name that doesn't
    /// exactly match the case-sensitive name of an existing rule in the rule group.
    ///
    /// You can use overrides for testing, for example you can override all of rule
    /// actions to `Count` and then monitor the resulting count metrics to
    /// understand how the rule group would handle your web traffic. You can also
    /// permanently override some or all actions, to modify how the rule group
    /// manages your web traffic.
    rule_action_overrides: ?[]const RuleActionOverride = null,

    /// An optional nested statement that narrows the scope of the web requests that
    /// are
    /// evaluated by the managed rule group. Requests are only evaluated by the rule
    /// group if they
    /// match the scope-down statement. You can use any nestable Statement in the
    /// scope-down statement, and you can nest statements at any level, the same as
    /// you can for a
    /// rule statement.
    scope_down_statement: ?*Statement = null,

    /// The name of the managed rule group vendor. You use this, along with the rule
    /// group name, to identify a rule group.
    vendor_name: []const u8,

    /// The version of the managed rule group to use. If you specify this, the
    /// version setting
    /// is fixed until you change it. If you don't specify this, WAF uses the
    /// vendor's
    /// default version, and then keeps the version at the vendor's default when the
    /// vendor updates
    /// the managed rule group settings.
    version: ?[]const u8 = null,

    pub const json_field_names = .{
        .excluded_rules = "ExcludedRules",
        .managed_rule_group_configs = "ManagedRuleGroupConfigs",
        .name = "Name",
        .rule_action_overrides = "RuleActionOverrides",
        .scope_down_statement = "ScopeDownStatement",
        .vendor_name = "VendorName",
        .version = "Version",
    };
};
