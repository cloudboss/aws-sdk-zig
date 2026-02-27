const ConfigRecommendation = @import("config_recommendation.zig").ConfigRecommendation;
const RecommendationComplianceStatus = @import("recommendation_compliance_status.zig").RecommendationComplianceStatus;

/// Defines recommendations for an Resilience Hub Application Component,
/// returned as an
/// object. This object contains component names, configuration recommendations,
/// and
/// recommendation statuses.
pub const ComponentRecommendation = struct {
    /// Name of the Application Component.
    app_component_name: []const u8,

    /// List of recommendations.
    config_recommendations: []const ConfigRecommendation,

    /// Status of the recommendation.
    recommendation_status: RecommendationComplianceStatus,

    pub const json_field_names = .{
        .app_component_name = "appComponentName",
        .config_recommendations = "configRecommendations",
        .recommendation_status = "recommendationStatus",
    };
};
