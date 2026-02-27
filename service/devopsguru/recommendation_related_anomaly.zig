const RecommendationRelatedAnomalyResource = @import("recommendation_related_anomaly_resource.zig").RecommendationRelatedAnomalyResource;
const RecommendationRelatedAnomalySourceDetail = @import("recommendation_related_anomaly_source_detail.zig").RecommendationRelatedAnomalySourceDetail;

/// Information about an anomaly that is related to a recommendation.
pub const RecommendationRelatedAnomaly = struct {
    /// The ID of an anomaly that generated the insight with this recommendation.
    anomaly_id: ?[]const u8,

    /// An array of objects that represent resources in which DevOps Guru detected
    /// anomalous
    /// behavior. Each object contains the name and type of the resource.
    resources: ?[]const RecommendationRelatedAnomalyResource,

    /// Information about where the anomalous behavior related the recommendation
    /// was found.
    /// For example, details in Amazon CloudWatch metrics.
    source_details: ?[]const RecommendationRelatedAnomalySourceDetail,

    pub const json_field_names = .{
        .anomaly_id = "AnomalyId",
        .resources = "Resources",
        .source_details = "SourceDetails",
    };
};
