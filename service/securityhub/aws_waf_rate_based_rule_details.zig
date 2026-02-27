const AwsWafRateBasedRuleMatchPredicate = @import("aws_waf_rate_based_rule_match_predicate.zig").AwsWafRateBasedRuleMatchPredicate;

/// Details about a rate-based rule for global resources. A rate-based rule
/// provides settings to indicate when to allow, block, or count a request.
/// Rate-based rules include the number of requests that arrive over a specified
/// period of time.
pub const AwsWafRateBasedRuleDetails = struct {
    /// The predicates to include in the rate-based rule.
    match_predicates: ?[]const AwsWafRateBasedRuleMatchPredicate,

    /// The name of the metrics for the rate-based rule.
    metric_name: ?[]const u8,

    /// The name of the rate-based rule.
    name: ?[]const u8,

    /// The field that WAF uses to determine whether requests are likely arriving
    /// from single source and are subject to rate monitoring.
    rate_key: ?[]const u8,

    /// The maximum number of requests that have an identical value for the field
    /// specified in `RateKey` that are allowed within a five-minute period. If the
    /// number of requests exceeds `RateLimit` and the other predicates specified in
    /// the rule are met, WAF triggers the action for the rule.
    rate_limit: ?i64,

    /// The unique identifier for the rate-based rule.
    rule_id: ?[]const u8,

    pub const json_field_names = .{
        .match_predicates = "MatchPredicates",
        .metric_name = "MetricName",
        .name = "Name",
        .rate_key = "RateKey",
        .rate_limit = "RateLimit",
        .rule_id = "RuleId",
    };
};
