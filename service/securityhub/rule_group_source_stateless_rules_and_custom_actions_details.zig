const RuleGroupSourceCustomActionsDetails = @import("rule_group_source_custom_actions_details.zig").RuleGroupSourceCustomActionsDetails;
const RuleGroupSourceStatelessRulesDetails = @import("rule_group_source_stateless_rules_details.zig").RuleGroupSourceStatelessRulesDetails;

/// Stateless rules and custom actions for a stateless rule group.
pub const RuleGroupSourceStatelessRulesAndCustomActionsDetails = struct {
    /// Custom actions for the rule group.
    custom_actions: ?[]const RuleGroupSourceCustomActionsDetails,

    /// Stateless rules for the rule group.
    stateless_rules: ?[]const RuleGroupSourceStatelessRulesDetails,

    pub const json_field_names = .{
        .custom_actions = "CustomActions",
        .stateless_rules = "StatelessRules",
    };
};
