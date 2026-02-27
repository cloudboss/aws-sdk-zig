const MetricStreamStatisticsMetric = @import("metric_stream_statistics_metric.zig").MetricStreamStatisticsMetric;

/// By default, a metric stream always sends the `MAX`, `MIN`,
/// `SUM`, and `SAMPLECOUNT` statistics for each metric that is
/// streamed. This structure contains information for one metric that includes
/// additional
/// statistics in the stream. For more information about statistics, see
/// CloudWatch,
/// listed in [
/// CloudWatch statistics
/// definitions](https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/Statistics-definitions.html.html).
pub const MetricStreamStatisticsConfiguration = struct {
    /// The list of additional statistics that are to be streamed for the metrics
    /// listed in
    /// the `IncludeMetrics` array in this structure. This list can include as many
    /// as 20 statistics.
    ///
    /// If the `OutputFormat` for the stream is `opentelemetry1.0` or
    /// `opentelemetry0.7`, the only valid values are
    /// `p*??*
    /// ` percentile statistics such as
    /// `p90`, `p99` and so on.
    ///
    /// If the `OutputFormat` for the stream is `json`, the valid values
    /// include the abbreviations for all of the statistics listed in [
    /// CloudWatch statistics
    /// definitions](https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/Statistics-definitions.html.html). For example, this includes
    /// `tm98, `
    /// `wm90`, `PR(:300)`, and so on.
    additional_statistics: []const []const u8,

    /// An array of metric name and namespace pairs that stream the additional
    /// statistics
    /// listed in the value of the `AdditionalStatistics` parameter. There can be as
    /// many as 100 pairs in the array.
    ///
    /// All metrics that match the combination of metric name and namespace will be
    /// streamed
    /// with the additional statistics, no matter their dimensions.
    include_metrics: []const MetricStreamStatisticsMetric,

    pub const json_field_names = .{
        .additional_statistics = "AdditionalStatistics",
        .include_metrics = "IncludeMetrics",
    };
};
