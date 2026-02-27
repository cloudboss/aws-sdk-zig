/// Network Firewall stateless rule group, used in a
/// NetworkFirewallPolicyDescription.
pub const StatelessRuleGroup = struct {
    /// The priority of the rule group. Network Firewall evaluates the stateless
    /// rule groups in a firewall policy starting from the lowest priority setting.
    priority: ?i32,

    /// The resource ID of the rule group.
    resource_id: ?[]const u8,

    /// The name of the rule group.
    rule_group_name: ?[]const u8,

    pub const json_field_names = .{
        .priority = "Priority",
        .resource_id = "ResourceId",
        .rule_group_name = "RuleGroupName",
    };
};
