const PerformanceInsightsMetricQuery = @import("performance_insights_metric_query.zig").PerformanceInsightsMetricQuery;

/// The query to retrieve metric data points.
pub const MetricQuery = struct {
    /// The Performance Insights query that you can use to retrieve Performance
    /// Insights metric data points.
    performance_insights_metric_query: ?PerformanceInsightsMetricQuery,
};
