const AwsWafRegionalRuleGroupRulesDetails = @import("aws_waf_regional_rule_group_rules_details.zig").AwsWafRegionalRuleGroupRulesDetails;

/// Provides information about an WAF Regional rule group. The rule group is a
/// collection of rules for inspecting and controlling web
/// requests.
pub const AwsWafRegionalRuleGroupDetails = struct {
    /// A name for the metrics for this rule group.
    metric_name: ?[]const u8 = null,

    /// The descriptive name of the rule group.
    name: ?[]const u8 = null,

    /// The ID of the rule group.
    rule_group_id: ?[]const u8 = null,

    /// Provides information about the rule statements used to identify the web
    /// requests that you want to allow, block, or
    /// count.
    rules: ?[]const AwsWafRegionalRuleGroupRulesDetails = null,

    pub const json_field_names = .{
        .metric_name = "MetricName",
        .name = "Name",
        .rule_group_id = "RuleGroupId",
        .rules = "Rules",
    };
};
