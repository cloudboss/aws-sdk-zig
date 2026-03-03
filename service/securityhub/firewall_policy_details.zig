const FirewallPolicyStatefulRuleGroupReferencesDetails = @import("firewall_policy_stateful_rule_group_references_details.zig").FirewallPolicyStatefulRuleGroupReferencesDetails;
const FirewallPolicyStatelessCustomActionsDetails = @import("firewall_policy_stateless_custom_actions_details.zig").FirewallPolicyStatelessCustomActionsDetails;
const FirewallPolicyStatelessRuleGroupReferencesDetails = @import("firewall_policy_stateless_rule_group_references_details.zig").FirewallPolicyStatelessRuleGroupReferencesDetails;

/// Defines the behavior of the firewall.
pub const FirewallPolicyDetails = struct {
    /// The stateful rule groups that are used in the firewall policy.
    stateful_rule_group_references: ?[]const FirewallPolicyStatefulRuleGroupReferencesDetails = null,

    /// The custom action definitions that are available to use in the firewall
    /// policy's `StatelessDefaultActions` setting.
    stateless_custom_actions: ?[]const FirewallPolicyStatelessCustomActionsDetails = null,

    /// The actions to take on a packet if it doesn't match any of the stateless
    /// rules in the policy.
    ///
    /// You must specify a standard action (`aws:pass`, `aws:drop`,
    /// `aws:forward_to_sfe`), and can optionally include a custom action from
    /// `StatelessCustomActions`.
    stateless_default_actions: ?[]const []const u8 = null,

    /// The actions to take on a fragmented UDP packet if it doesn't match any of
    /// the stateless rules in the policy.
    ///
    /// You must specify a standard action (`aws:pass`, `aws:drop`,
    /// `aws:forward_to_sfe`), and can optionally include a custom action from
    /// `StatelessCustomActions`.
    stateless_fragment_default_actions: ?[]const []const u8 = null,

    /// The stateless rule groups that are used in the firewall policy.
    stateless_rule_group_references: ?[]const FirewallPolicyStatelessRuleGroupReferencesDetails = null,

    pub const json_field_names = .{
        .stateful_rule_group_references = "StatefulRuleGroupReferences",
        .stateless_custom_actions = "StatelessCustomActions",
        .stateless_default_actions = "StatelessDefaultActions",
        .stateless_fragment_default_actions = "StatelessFragmentDefaultActions",
        .stateless_rule_group_references = "StatelessRuleGroupReferences",
    };
};
