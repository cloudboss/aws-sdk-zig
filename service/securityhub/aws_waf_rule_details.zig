const AwsWafRulePredicateListDetails = @import("aws_waf_rule_predicate_list_details.zig").AwsWafRulePredicateListDetails;

/// Provides information about a WAF rule. This rule specifies the web requests
/// that you want to allow, block, or count.
pub const AwsWafRuleDetails = struct {
    /// The name of the metrics for this rule.
    metric_name: ?[]const u8 = null,

    /// A descriptive name for the rule.
    name: ?[]const u8 = null,

    /// Specifies the `ByteMatchSet`, `IPSet`, `SqlInjectionMatchSet`,
    /// `XssMatchSet`,
    /// `RegexMatchSet`, `GeoMatchSet`, and `SizeConstraintSet` objects that you
    /// want to add to a rule and,
    /// for each object, indicates whether you want to negate the settings.
    predicate_list: ?[]const AwsWafRulePredicateListDetails = null,

    /// The ID of the WAF rule.
    rule_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .metric_name = "MetricName",
        .name = "Name",
        .predicate_list = "PredicateList",
        .rule_id = "RuleId",
    };
};
