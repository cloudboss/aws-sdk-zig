/// This structure contains the definition for a Contributor Insights rule. For
/// more
/// information about this rule, see[ Using Constributor Insights to analyze
/// high-cardinality
/// data](https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/ContributorInsights.html) in the
/// *Amazon CloudWatch User Guide*.
pub const InsightRule = struct {
    /// Displays whether the rule is evaluated on the transformed versions of logs,
    /// for log groups
    /// that have [Log
    /// transformation](https://docs.aws.amazon.com/AmazonCloudWatch/latest/logs/CloudWatch-Logs-Transformation.html) enabled. If this is `false`, log events are evaluated before they are transformed.
    apply_on_transformed_logs: ?bool = null,

    /// The definition of the rule, as a JSON object. The definition contains the
    /// keywords
    /// used to define contributors, the value to aggregate on if this rule returns
    /// a sum
    /// instead of a count, and the filters. For details on the valid syntax, see
    /// [Contributor Insights Rule
    /// Syntax](https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/ContributorInsights-RuleSyntax.html).
    definition: []const u8,

    /// An optional built-in rule that Amazon Web Services manages.
    managed_rule: ?bool = null,

    /// The name of the rule.
    name: []const u8,

    /// For rules that you create, this is always `{"Name": "CloudWatchLogRule",
    /// "Version": 1}`. For managed rules, this is `{"Name": "ServiceLogRule",
    /// "Version": 1}`
    schema: []const u8,

    /// Indicates whether the rule is enabled or disabled.
    state: []const u8,

    pub const json_field_names = .{
        .apply_on_transformed_logs = "ApplyOnTransformedLogs",
        .definition = "Definition",
        .managed_rule = "ManagedRule",
        .name = "Name",
        .schema = "Schema",
        .state = "State",
    };
};
