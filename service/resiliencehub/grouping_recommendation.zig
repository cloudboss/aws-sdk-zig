const GroupingRecommendationConfidenceLevel = @import("grouping_recommendation_confidence_level.zig").GroupingRecommendationConfidenceLevel;
const GroupingAppComponent = @import("grouping_app_component.zig").GroupingAppComponent;
const GroupingRecommendationRejectionReason = @import("grouping_recommendation_rejection_reason.zig").GroupingRecommendationRejectionReason;
const GroupingResource = @import("grouping_resource.zig").GroupingResource;
const GroupingRecommendationStatusType = @import("grouping_recommendation_status_type.zig").GroupingRecommendationStatusType;

/// Creates a new grouping recommendation.
pub const GroupingRecommendation = struct {
    /// Indicates the confidence level of Resilience Hub on the grouping
    /// recommendation.
    confidence_level: GroupingRecommendationConfidenceLevel,

    /// Indicates the creation time of the grouping recommendation.
    creation_time: i64,

    /// Indicates the name of the recommended Application Component (AppComponent).
    grouping_app_component: GroupingAppComponent,

    /// Indicates all the reasons available for rejecting a grouping recommendation.
    grouping_recommendation_id: []const u8,

    /// Indicates all the reasons available for rejecting a grouping recommendation.
    recommendation_reasons: []const []const u8,

    /// Indicates the reason you had selected while rejecting a grouping
    /// recommendation.
    rejection_reason: ?GroupingRecommendationRejectionReason,

    /// Indicates the resources that are grouped in a recommended AppComponent.
    resources: []const GroupingResource,

    /// Indicates the confidence level of the grouping recommendation.
    score: f64 = 0,

    /// Indicates the status of grouping resources into AppComponents.
    status: GroupingRecommendationStatusType,

    pub const json_field_names = .{
        .confidence_level = "confidenceLevel",
        .creation_time = "creationTime",
        .grouping_app_component = "groupingAppComponent",
        .grouping_recommendation_id = "groupingRecommendationId",
        .recommendation_reasons = "recommendationReasons",
        .rejection_reason = "rejectionReason",
        .resources = "resources",
        .score = "score",
        .status = "status",
    };
};
