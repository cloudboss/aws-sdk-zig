const InsightRuleContributorDatapoint = @import("insight_rule_contributor_datapoint.zig").InsightRuleContributorDatapoint;

/// One of the unique contributors found by a Contributor Insights rule. If the
/// rule
/// contains multiple keys, then a unique contributor is a unique combination of
/// values from
/// all the keys in the rule.
///
/// If the rule contains a single key, then each unique contributor is each
/// unique value
/// for this key.
///
/// For more information, see
/// [GetInsightRuleReport](https://docs.aws.amazon.com/AmazonCloudWatch/latest/APIReference/API_GetInsightRuleReport.html).
pub const InsightRuleContributor = struct {
    /// An approximation of the aggregate value that comes from this contributor.
    approximate_aggregate_value: f64,

    /// An array of the data points where this contributor is present. Only the data
    /// points
    /// when this contributor appeared are included in the array.
    datapoints: []const InsightRuleContributorDatapoint,

    /// One of the log entry field keywords that is used to define contributors for
    /// this
    /// rule.
    keys: []const []const u8,

    pub const json_field_names = .{
        .approximate_aggregate_value = "ApproximateAggregateValue",
        .datapoints = "Datapoints",
        .keys = "Keys",
    };
};
