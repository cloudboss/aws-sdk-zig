const ManagedRuleGroupStatement = @import("managed_rule_group_statement.zig").ManagedRuleGroupStatement;
const RuleGroupReferenceStatement = @import("rule_group_reference_statement.zig").RuleGroupReferenceStatement;

/// The processing guidance for an Firewall Manager rule. This is like a regular
/// rule Statement, but it can only contain a single rule group reference.
pub const FirewallManagerStatement = struct {
    /// A statement used by Firewall Manager to run the rules that are defined in a
    /// managed rule group. This is managed by Firewall Manager for an Firewall
    /// Manager WAF policy.
    managed_rule_group_statement: ?ManagedRuleGroupStatement,

    /// A statement used by Firewall Manager to run the rules that are defined in a
    /// rule group. This is managed by Firewall Manager for an Firewall Manager WAF
    /// policy.
    rule_group_reference_statement: ?RuleGroupReferenceStatement,

    pub const json_field_names = .{
        .managed_rule_group_statement = "ManagedRuleGroupStatement",
        .rule_group_reference_statement = "RuleGroupReferenceStatement",
    };
};
