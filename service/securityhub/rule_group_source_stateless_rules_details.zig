const RuleGroupSourceStatelessRuleDefinition = @import("rule_group_source_stateless_rule_definition.zig").RuleGroupSourceStatelessRuleDefinition;

/// A stateless rule in the rule group.
pub const RuleGroupSourceStatelessRulesDetails = struct {
    /// Indicates the order in which to run this rule relative to all of the rules
    /// in the stateless rule group.
    priority: ?i32 = null,

    /// Provides the definition of the stateless rule.
    rule_definition: ?RuleGroupSourceStatelessRuleDefinition = null,

    pub const json_field_names = .{
        .priority = "Priority",
        .rule_definition = "RuleDefinition",
    };
};
