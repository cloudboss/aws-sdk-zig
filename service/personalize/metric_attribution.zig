const MetricAttributionOutput = @import("metric_attribution_output.zig").MetricAttributionOutput;

/// Contains information on a metric attribution. A metric attribution creates
/// reports on the data that you import into Amazon Personalize.
/// Depending on how you import the data, you can view reports in Amazon
/// CloudWatch or Amazon S3.
/// For more information, see [Measuring impact of
/// recommendations](https://docs.aws.amazon.com/personalize/latest/dg/measuring-recommendation-impact.html).
pub const MetricAttribution = struct {
    /// The metric attribution's creation date time.
    creation_date_time: ?i64,

    /// The metric attribution's dataset group Amazon Resource Name (ARN).
    dataset_group_arn: ?[]const u8,

    /// The metric attribution's failure reason.
    failure_reason: ?[]const u8,

    /// The metric attribution's last updated date time.
    last_updated_date_time: ?i64,

    /// The metric attribution's Amazon Resource Name (ARN).
    metric_attribution_arn: ?[]const u8,

    /// The metric attribution's output configuration.
    metrics_output_config: ?MetricAttributionOutput,

    /// The metric attribution's name.
    name: ?[]const u8,

    /// The metric attribution's status.
    status: ?[]const u8,

    pub const json_field_names = .{
        .creation_date_time = "creationDateTime",
        .dataset_group_arn = "datasetGroupArn",
        .failure_reason = "failureReason",
        .last_updated_date_time = "lastUpdatedDateTime",
        .metric_attribution_arn = "metricAttributionArn",
        .metrics_output_config = "metricsOutputConfig",
        .name = "name",
        .status = "status",
    };
};
