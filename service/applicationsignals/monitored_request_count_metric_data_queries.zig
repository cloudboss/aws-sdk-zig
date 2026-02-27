const MetricDataQuery = @import("metric_data_query.zig").MetricDataQuery;

/// This structure defines the metric that is used as the "good request" or "bad
/// request" value for a request-based SLO. This value observed for the metric
/// defined in `TotalRequestCountMetric` is divided by the number found for
/// `MonitoredRequestCountMetric` to determine the percentage of successful
/// requests that this SLO tracks.
pub const MonitoredRequestCountMetricDataQueries = union(enum) {
    /// If you want to count "bad requests" to determine the percentage of
    /// successful requests for this request-based SLO, specify the metric to use as
    /// "bad requests" in this structure.
    bad_count_metric: ?[]const MetricDataQuery,
    /// If you want to count "good requests" to determine the percentage of
    /// successful requests for this request-based SLO, specify the metric to use as
    /// "good requests" in this structure.
    good_count_metric: ?[]const MetricDataQuery,

    pub const json_field_names = .{
        .bad_count_metric = "BadCountMetric",
        .good_count_metric = "GoodCountMetric",
    };
};
