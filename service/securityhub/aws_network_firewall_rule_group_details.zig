const RuleGroupDetails = @import("rule_group_details.zig").RuleGroupDetails;

/// Details about an Network Firewall rule group. Rule groups are used to
/// inspect and control network traffic. Stateless rule groups apply to
/// individual packets. Stateful rule groups apply to packets in the context of
/// their traffic flow.
///
/// Rule groups are referenced in firewall policies.
pub const AwsNetworkFirewallRuleGroupDetails = struct {
    /// The maximum number of operating resources that this rule group can use.
    capacity: ?i32,

    /// A description of the rule group.
    description: ?[]const u8,

    /// Details about the rule group.
    rule_group: ?RuleGroupDetails,

    /// The ARN of the rule group.
    rule_group_arn: ?[]const u8,

    /// The identifier of the rule group.
    rule_group_id: ?[]const u8,

    /// The descriptive name of the rule group.
    rule_group_name: ?[]const u8,

    /// The type of rule group. A rule group can be stateful or stateless.
    type: ?[]const u8,

    pub const json_field_names = .{
        .capacity = "Capacity",
        .description = "Description",
        .rule_group = "RuleGroup",
        .rule_group_arn = "RuleGroupArn",
        .rule_group_id = "RuleGroupId",
        .rule_group_name = "RuleGroupName",
        .type = "Type",
    };
};
