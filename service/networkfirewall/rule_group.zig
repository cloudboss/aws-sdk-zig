const ReferenceSets = @import("reference_sets.zig").ReferenceSets;
const RulesSource = @import("rules_source.zig").RulesSource;
const RuleVariables = @import("rule_variables.zig").RuleVariables;
const StatefulRuleOptions = @import("stateful_rule_options.zig").StatefulRuleOptions;

/// The object that defines the rules in a rule group. This, along with
/// RuleGroupResponse, define the rule group. You can retrieve all objects for a
/// rule group by calling DescribeRuleGroup.
///
/// Network Firewall uses a rule group to inspect and control network traffic.
/// You define stateless rule groups to inspect individual packets and you
/// define stateful rule groups to inspect packets in the context of their
/// traffic flow.
///
/// To use a rule group, you include it by reference in an Network Firewall
/// firewall policy, then you use the policy in a firewall. You can reference a
/// rule group from
/// more than one firewall policy, and you can use a firewall policy in more
/// than one firewall.
pub const RuleGroup = struct {
    /// The list of a rule group's reference sets.
    reference_sets: ?ReferenceSets,

    /// The stateful rules or stateless rules for the rule group.
    rules_source: RulesSource,

    /// Settings that are available for use in the rules in the rule group. You can
    /// only use
    /// these for stateful rule groups.
    rule_variables: ?RuleVariables,

    /// Additional options governing how Network Firewall handles stateful rules.
    /// The policies where you use your stateful
    /// rule group must have stateful rule options settings that are compatible with
    /// these settings. Some limitations apply; for more information, see [Strict
    /// evaluation
    /// order](https://docs.aws.amazon.com/network-firewall/latest/developerguide/suricata-limitations-caveats.html) in the *Network Firewall Developer Guide*.
    stateful_rule_options: ?StatefulRuleOptions,

    pub const json_field_names = .{
        .reference_sets = "ReferenceSets",
        .rules_source = "RulesSource",
        .rule_variables = "RuleVariables",
        .stateful_rule_options = "StatefulRuleOptions",
    };
};
