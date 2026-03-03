const CloudWatchMetricsDetail = @import("cloud_watch_metrics_detail.zig").CloudWatchMetricsDetail;
const PerformanceInsightsMetricsDetail = @import("performance_insights_metrics_detail.zig").PerformanceInsightsMetricsDetail;

/// Details about the source of the anomalous operational data that triggered
/// the
/// anomaly.
pub const AnomalySourceDetails = struct {
    /// An array of `CloudWatchMetricsDetail` objects that contain information
    /// about analyzed CloudWatch metrics that show anomalous behavior.
    cloud_watch_metrics: ?[]const CloudWatchMetricsDetail = null,

    /// An array of `PerformanceInsightsMetricsDetail` objects that contain
    /// information about analyzed Performance Insights metrics that show anomalous
    /// behavior.
    performance_insights_metrics: ?[]const PerformanceInsightsMetricsDetail = null,

    pub const json_field_names = .{
        .cloud_watch_metrics = "CloudWatchMetrics",
        .performance_insights_metrics = "PerformanceInsightsMetrics",
    };
};
