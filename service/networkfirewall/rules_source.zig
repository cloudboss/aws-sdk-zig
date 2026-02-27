const RulesSourceList = @import("rules_source_list.zig").RulesSourceList;
const StatefulRule = @import("stateful_rule.zig").StatefulRule;
const StatelessRulesAndCustomActions = @import("stateless_rules_and_custom_actions.zig").StatelessRulesAndCustomActions;

/// The stateless or stateful rules definitions for use in a single rule group.
/// Each rule
/// group requires a single `RulesSource`. You can use an instance of this for
/// either stateless rules or stateful rules.
pub const RulesSource = struct {
    /// Stateful inspection criteria for a domain list rule group.
    rules_source_list: ?RulesSourceList,

    /// Stateful inspection criteria, provided in Suricata compatible rules.
    /// Suricata is an open-source threat detection framework that includes a
    /// standard
    /// rule-based language for network traffic inspection.
    ///
    /// These rules contain the inspection criteria and the action to take for
    /// traffic that
    /// matches the criteria, so this type of rule group doesn't have a separate
    /// action
    /// setting.
    ///
    /// You can't use the `priority` keyword if the `RuleOrder` option in
    /// StatefulRuleOptions is set to `STRICT_ORDER`.
    rules_string: ?[]const u8,

    /// An array of individual stateful rules inspection criteria to be used
    /// together in a stateful rule group.
    /// Use this option to specify simple Suricata rules with protocol, source and
    /// destination, ports, direction, and rule options.
    /// For information about the Suricata `Rules` format, see
    /// [Rules
    /// Format](https://suricata.readthedocs.io/en/suricata-7.0.3/rules/intro.html).
    stateful_rules: ?[]const StatefulRule,

    /// Stateless inspection criteria to be used in a stateless rule group.
    stateless_rules_and_custom_actions: ?StatelessRulesAndCustomActions,

    pub const json_field_names = .{
        .rules_source_list = "RulesSourceList",
        .rules_string = "RulesString",
        .stateful_rules = "StatefulRules",
        .stateless_rules_and_custom_actions = "StatelessRulesAndCustomActions",
    };
};
