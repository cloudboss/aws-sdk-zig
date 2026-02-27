const RuleGroupSourceStatelessRuleMatchAttributes = @import("rule_group_source_stateless_rule_match_attributes.zig").RuleGroupSourceStatelessRuleMatchAttributes;

/// The definition of the stateless rule.
pub const RuleGroupSourceStatelessRuleDefinition = struct {
    /// The actions to take on a packet that matches one of the stateless rule
    /// definition's match attributes. You must specify a standard action
    /// (`aws:pass`, `aws:drop`, or `aws:forward_to_sfe`). You can then add custom
    /// actions.
    actions: ?[]const []const u8,

    /// The criteria for Network Firewall to use to inspect an individual packet in
    /// a stateless rule inspection.
    match_attributes: ?RuleGroupSourceStatelessRuleMatchAttributes,

    pub const json_field_names = .{
        .actions = "Actions",
        .match_attributes = "MatchAttributes",
    };
};
