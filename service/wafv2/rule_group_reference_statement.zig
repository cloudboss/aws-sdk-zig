const ExcludedRule = @import("excluded_rule.zig").ExcludedRule;
const RuleActionOverride = @import("rule_action_override.zig").RuleActionOverride;

/// A rule statement used to run the rules that are defined in a RuleGroup. To
/// use this, create a rule group with your rules, then provide the ARN of the
/// rule group in this statement.
///
/// You cannot nest a `RuleGroupReferenceStatement`, for example for use inside
/// a `NotStatement` or `OrStatement`. You cannot use a rule group
/// reference statement inside another rule group. You can only reference a rule
/// group as a top-level statement within a rule that you define in a web ACL.
pub const RuleGroupReferenceStatement = struct {
    /// The Amazon Resource Name (ARN) of the entity.
    arn: []const u8,

    /// Rules in the referenced rule group whose actions are set to `Count`.
    ///
    /// Instead of this option, use `RuleActionOverrides`. It accepts any valid
    /// action setting, including `Count`.
    excluded_rules: ?[]const ExcludedRule,

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
    rule_action_overrides: ?[]const RuleActionOverride,

    pub const json_field_names = .{
        .arn = "ARN",
        .excluded_rules = "ExcludedRules",
        .rule_action_overrides = "RuleActionOverrides",
    };
};
