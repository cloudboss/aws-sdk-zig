/// Contains information on a metric that a metric attribution reports on. For
/// more information, see [Measuring impact of
/// recommendations](https://docs.aws.amazon.com/personalize/latest/dg/measuring-recommendation-impact.html).
pub const MetricAttribute = struct {
    /// The metric's event type.
    event_type: []const u8,

    /// The attribute's expression. Available functions are `SUM()` or
    /// `SAMPLECOUNT()`. For SUM() functions, provide the
    /// dataset type (either Interactions or Items) and column to sum as a
    /// parameter. For example SUM(Items.PRICE).
    expression: []const u8,

    /// The metric's name. The name helps you identify the metric in Amazon
    /// CloudWatch or Amazon S3.
    metric_name: []const u8,

    pub const json_field_names = .{
        .event_type = "eventType",
        .expression = "expression",
        .metric_name = "metricName",
    };
};
