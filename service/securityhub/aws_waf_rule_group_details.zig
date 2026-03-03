const AwsWafRuleGroupRulesDetails = @import("aws_waf_rule_group_rules_details.zig").AwsWafRuleGroupRulesDetails;

/// Provides information about an WAF rule group. A rule group is a collection
/// of rules for inspecting and controlling web requests.
pub const AwsWafRuleGroupDetails = struct {
    /// The name of the metrics for this rule group.
    metric_name: ?[]const u8 = null,

    /// The name of the rule group.
    name: ?[]const u8 = null,

    /// The ID of the rule group.
    rule_group_id: ?[]const u8 = null,

    /// Provides information about the rules attached to the rule group. These rules
    /// identify the web requests that you want to
    /// allow, block, or count.
    rules: ?[]const AwsWafRuleGroupRulesDetails = null,

    pub const json_field_names = .{
        .metric_name = "MetricName",
        .name = "Name",
        .rule_group_id = "RuleGroupId",
        .rules = "Rules",
    };
};
