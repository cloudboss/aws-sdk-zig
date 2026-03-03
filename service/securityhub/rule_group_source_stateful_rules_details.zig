const RuleGroupSourceStatefulRulesHeaderDetails = @import("rule_group_source_stateful_rules_header_details.zig").RuleGroupSourceStatefulRulesHeaderDetails;
const RuleGroupSourceStatefulRulesOptionsDetails = @import("rule_group_source_stateful_rules_options_details.zig").RuleGroupSourceStatefulRulesOptionsDetails;

/// A Suricata rule specification.
pub const RuleGroupSourceStatefulRulesDetails = struct {
    /// Defines what Network Firewall should do with the packets in a traffic flow
    /// when the flow matches the stateful rule criteria.
    action: ?[]const u8 = null,

    /// The stateful inspection criteria for the rule.
    header: ?RuleGroupSourceStatefulRulesHeaderDetails = null,

    /// Additional options for the rule.
    rule_options: ?[]const RuleGroupSourceStatefulRulesOptionsDetails = null,

    pub const json_field_names = .{
        .action = "Action",
        .header = "Header",
        .rule_options = "RuleOptions",
    };
};
