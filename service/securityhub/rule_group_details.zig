const RuleGroupSource = @import("rule_group_source.zig").RuleGroupSource;
const RuleGroupVariables = @import("rule_group_variables.zig").RuleGroupVariables;

/// Details about the rule group.
pub const RuleGroupDetails = struct {
    /// The rules and actions for the rule group.
    ///
    /// For stateful rule groups, can contain `RulesString`, `RulesSourceList`, or
    /// `StatefulRules`.
    ///
    /// For stateless rule groups, contains `StatelessRulesAndCustomActions`.
    rules_source: ?RuleGroupSource = null,

    /// Additional settings to use in the specified rules.
    rule_variables: ?RuleGroupVariables = null,

    pub const json_field_names = .{
        .rules_source = "RulesSource",
        .rule_variables = "RuleVariables",
    };
};
