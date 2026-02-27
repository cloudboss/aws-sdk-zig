const RuleAction = @import("rule_action.zig").RuleAction;

/// High-level information about a Rule, returned by operations like
/// DescribeManagedRuleGroup. This provides information like the ID, that you
/// can use to retrieve and manage a `RuleGroup`, and the ARN, that you provide
/// to the RuleGroupReferenceStatement to use the rule group in a Rule.
pub const RuleSummary = struct {
    /// The action that WAF should take on a web request when it matches a rule's
    /// statement. Settings at the web ACL level can override the rule action
    /// setting.
    action: ?RuleAction,

    /// The name of the rule.
    name: ?[]const u8,

    pub const json_field_names = .{
        .action = "Action",
        .name = "Name",
    };
};
