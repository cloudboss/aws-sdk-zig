const PerformanceInsightsMetricQuery = @import("performance_insights_metric_query.zig").PerformanceInsightsMetricQuery;

/// Information about a reference metric used to evaluate Performance Insights.
pub const PerformanceInsightsReferenceMetric = struct {
    /// A query to be processed on the metric.
    metric_query: ?PerformanceInsightsMetricQuery,

    pub const json_field_names = .{
        .metric_query = "MetricQuery",
    };
};
