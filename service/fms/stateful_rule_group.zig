const NetworkFirewallStatefulRuleGroupOverride = @import("network_firewall_stateful_rule_group_override.zig").NetworkFirewallStatefulRuleGroupOverride;

/// Network Firewall stateful rule group, used in a
/// NetworkFirewallPolicyDescription.
pub const StatefulRuleGroup = struct {
    /// The action that allows the policy owner to override the behavior of the rule
    /// group within a policy.
    override: ?NetworkFirewallStatefulRuleGroupOverride,

    /// An integer setting that indicates the order in which to run the stateful
    /// rule groups in a single
    /// Network Firewall firewall policy. This setting only applies to firewall
    /// policies that specify the `STRICT_ORDER`
    /// rule order in the stateful engine options settings.
    ///
    /// Network Firewall evalutes each stateful rule group against a packet starting
    /// with the group that has
    /// the lowest priority setting. You must ensure that the priority settings are
    /// unique within each policy. For information about
    ///
    /// You can change the priority settings of your rule groups at any time. To
    /// make it easier to insert rule
    /// groups later, number them so there's a wide range in between, for example
    /// use 100, 200, and so on.
    priority: ?i32,

    /// The resource ID of the rule group.
    resource_id: ?[]const u8,

    /// The name of the rule group.
    rule_group_name: ?[]const u8,

    pub const json_field_names = .{
        .override = "Override",
        .priority = "Priority",
        .resource_id = "ResourceId",
        .rule_group_name = "RuleGroupName",
    };
};
