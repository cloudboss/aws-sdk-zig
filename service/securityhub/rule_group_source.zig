const RuleGroupSourceListDetails = @import("rule_group_source_list_details.zig").RuleGroupSourceListDetails;
const RuleGroupSourceStatefulRulesDetails = @import("rule_group_source_stateful_rules_details.zig").RuleGroupSourceStatefulRulesDetails;
const RuleGroupSourceStatelessRulesAndCustomActionsDetails = @import("rule_group_source_stateless_rules_and_custom_actions_details.zig").RuleGroupSourceStatelessRulesAndCustomActionsDetails;

/// The rules and actions for the rule group.
pub const RuleGroupSource = struct {
    /// Stateful inspection criteria for a domain list rule group. A domain list
    /// rule group determines access by specific protocols to specific domains.
    rules_source_list: ?RuleGroupSourceListDetails = null,

    /// Stateful inspection criteria, provided in Suricata compatible intrusion
    /// prevention system (IPS) rules.
    rules_string: ?[]const u8 = null,

    /// Suricata rule specifications.
    stateful_rules: ?[]const RuleGroupSourceStatefulRulesDetails = null,

    /// The stateless rules and custom actions used by a stateless rule group.
    stateless_rules_and_custom_actions: ?RuleGroupSourceStatelessRulesAndCustomActionsDetails = null,

    pub const json_field_names = .{
        .rules_source_list = "RulesSourceList",
        .rules_string = "RulesString",
        .stateful_rules = "StatefulRules",
        .stateless_rules_and_custom_actions = "StatelessRulesAndCustomActions",
    };
};
