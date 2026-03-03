const NetworkFirewallOverrideAction = @import("network_firewall_override_action.zig").NetworkFirewallOverrideAction;

/// The setting that allows the policy owner to change the behavior of the rule
/// group within a policy.
pub const NetworkFirewallStatefulRuleGroupOverride = struct {
    /// The action that changes the rule group from `DROP` to `ALERT`. This only
    /// applies to managed rule groups.
    action: ?NetworkFirewallOverrideAction = null,

    pub const json_field_names = .{
        .action = "Action",
    };
};
