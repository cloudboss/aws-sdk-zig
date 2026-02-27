const RecommendationRelatedCloudWatchMetricsSourceDetail = @import("recommendation_related_cloud_watch_metrics_source_detail.zig").RecommendationRelatedCloudWatchMetricsSourceDetail;

/// Contains an array of `RecommendationRelatedCloudWatchMetricsSourceDetail`
/// objects that contain the name and namespace of an Amazon CloudWatch metric.
pub const RecommendationRelatedAnomalySourceDetail = struct {
    /// An array of `CloudWatchMetricsDetail` objects that contains information
    /// about the analyzed metrics that displayed anomalous behavior.
    cloud_watch_metrics: ?[]const RecommendationRelatedCloudWatchMetricsSourceDetail,

    pub const json_field_names = .{
        .cloud_watch_metrics = "CloudWatchMetrics",
    };
};
