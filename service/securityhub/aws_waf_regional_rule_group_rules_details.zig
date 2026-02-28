const AwsWafRegionalRuleGroupRulesActionDetails = @import("aws_waf_regional_rule_group_rules_action_details.zig").AwsWafRegionalRuleGroupRulesActionDetails;

/// Provides information about the rules attached to a rule group
pub const AwsWafRegionalRuleGroupRulesDetails = struct {
    /// The action that WAF should take on a web request when it matches the
    /// criteria defined in the rule.
    action: ?AwsWafRegionalRuleGroupRulesActionDetails,

    /// If you define more than one rule in a web ACL, WAF evaluates each request
    /// against the rules in
    /// order based on the value of `Priority`.
    priority: ?i32,

    /// The ID for a rule.
    rule_id: ?[]const u8,

    /// The type of rule in the rule group.
    @"type": ?[]const u8,

    pub const json_field_names = .{
        .action = "Action",
        .priority = "Priority",
        .rule_id = "RuleId",
        .@"type" = "Type",
    };
};
