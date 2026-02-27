const PerformanceInsightsMetric = @import("performance_insights_metric.zig").PerformanceInsightsMetric;

/// List of data objects which provide details about source metrics.
/// This field can be used to determine the PI metric to render
/// for the insight. This data type also includes static values
/// for the metrics for the Insight that were calculated and included
/// in text and annotations on the DB load chart.
pub const Data = struct {
    /// This field determines the Performance Insights metric to render
    /// for the insight. The `name` field refers to a Performance Insights metric.
    performance_insights_metric: ?PerformanceInsightsMetric,

    pub const json_field_names = .{
        .performance_insights_metric = "PerformanceInsightsMetric",
    };
};
