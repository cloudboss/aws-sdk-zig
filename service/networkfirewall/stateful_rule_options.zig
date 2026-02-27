const RuleOrder = @import("rule_order.zig").RuleOrder;

/// Additional options governing how Network Firewall handles the rule group.
/// You can only use these for stateful rule groups.
pub const StatefulRuleOptions = struct {
    /// Indicates how to manage the order of the rule evaluation for the rule group.
    /// `DEFAULT_ACTION_ORDER` is
    /// the default behavior. Stateful rules are provided to the rule engine as
    /// Suricata compatible strings, and Suricata evaluates them
    /// based on certain settings. For more information, see
    /// [Evaluation order for stateful
    /// rules](https://docs.aws.amazon.com/network-firewall/latest/developerguide/suricata-rule-evaluation-order.html) in the *Network Firewall Developer Guide*.
    rule_order: ?RuleOrder,

    pub const json_field_names = .{
        .rule_order = "RuleOrder",
    };
};
