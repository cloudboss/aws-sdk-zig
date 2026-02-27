/// This object contains the information for one metric that is to be streamed
/// with
/// additional statistics.
pub const MetricStreamStatisticsMetric = struct {
    /// The name of the metric.
    metric_name: []const u8,

    /// The namespace of the metric.
    namespace: []const u8,

    pub const json_field_names = .{
        .metric_name = "MetricName",
        .namespace = "Namespace",
    };
};
