const AwsWafRegionalRulePredicateListDetails = @import("aws_waf_regional_rule_predicate_list_details.zig").AwsWafRegionalRulePredicateListDetails;

/// Provides information about an WAF Regional rule. This rule identifies the
/// web requests that you want to allow, block, or count.
pub const AwsWafRegionalRuleDetails = struct {
    /// A name for the metrics for the rule.
    metric_name: ?[]const u8 = null,

    /// A descriptive name for the rule.
    name: ?[]const u8 = null,

    /// Specifies the `ByteMatchSet`, `IPSet`,
    /// `SqlInjectionMatchSet`, `XssMatchSet`, `RegexMatchSet`,
    /// `GeoMatchSet`, and `SizeConstraintSet` objects that you want to
    /// add to a rule and, for each object, indicates whether you want to negate the
    /// settings.
    predicate_list: ?[]const AwsWafRegionalRulePredicateListDetails = null,

    /// The ID of the rule.
    rule_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .metric_name = "MetricName",
        .name = "Name",
        .predicate_list = "PredicateList",
        .rule_id = "RuleId",
    };
};
