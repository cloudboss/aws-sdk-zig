const AwsWafRuleGroupRulesActionDetails = @import("aws_waf_rule_group_rules_action_details.zig").AwsWafRuleGroupRulesActionDetails;

/// Provides information about the rules attached to the rule group. These rules
/// identify the web requests that you want to
/// allow, block, or count.
pub const AwsWafRuleGroupRulesDetails = struct {
    /// Provides information about what action WAF should take on a web request when
    /// it matches the criteria defined in the rule.
    action: ?AwsWafRuleGroupRulesActionDetails,

    /// If you define more than one rule in a web ACL, WAF evaluates each request
    /// against the rules in order
    /// based on the value of `Priority`.
    priority: ?i32,

    /// The rule ID for a rule.
    rule_id: ?[]const u8,

    /// The type of rule.
    type: ?[]const u8,

    pub const json_field_names = .{
        .action = "Action",
        .priority = "Priority",
        .rule_id = "RuleId",
        .type = "Type",
    };
};
