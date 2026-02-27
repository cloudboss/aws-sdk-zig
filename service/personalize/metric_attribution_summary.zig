/// Provides a summary of the properties of a metric attribution. For a complete
/// listing, call the
/// [DescribeMetricAttribution](https://docs.aws.amazon.com/personalize/latest/dg/API_DescribeMetricAttribution.html).
pub const MetricAttributionSummary = struct {
    /// The metric attribution's creation date time.
    creation_date_time: ?i64,

    /// The metric attribution's failure reason.
    failure_reason: ?[]const u8,

    /// The metric attribution's last updated date time.
    last_updated_date_time: ?i64,

    /// The metric attribution's Amazon Resource Name (ARN).
    metric_attribution_arn: ?[]const u8,

    /// The name of the metric attribution.
    name: ?[]const u8,

    /// The metric attribution's status.
    status: ?[]const u8,

    pub const json_field_names = .{
        .creation_date_time = "creationDateTime",
        .failure_reason = "failureReason",
        .last_updated_date_time = "lastUpdatedDateTime",
        .metric_attribution_arn = "metricAttributionArn",
        .name = "name",
        .status = "status",
    };
};
