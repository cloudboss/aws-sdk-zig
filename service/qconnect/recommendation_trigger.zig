const RecommendationTriggerData = @import("recommendation_trigger_data.zig").RecommendationTriggerData;
const RecommendationSourceType = @import("recommendation_source_type.zig").RecommendationSourceType;
const RecommendationTriggerType = @import("recommendation_trigger_type.zig").RecommendationTriggerType;

/// A recommendation trigger provides context on the event that produced the
/// referenced recommendations. Recommendations are only referenced in
/// `recommendationIds` by a single RecommendationTrigger.
pub const RecommendationTrigger = struct {
    /// A union type containing information related to the trigger.
    data: RecommendationTriggerData,

    /// The identifier of the recommendation trigger.
    id: []const u8,

    /// The identifiers of the recommendations.
    recommendation_ids: []const []const u8,

    /// The source of the recommendation trigger.
    ///
    /// * ISSUE_DETECTION: The corresponding recommendations were triggered by a
    ///   Contact Lens issue.
    /// * RULE_EVALUATION: The corresponding recommendations were triggered by a
    ///   Contact Lens rule.
    source: RecommendationSourceType,

    /// The type of recommendation trigger.
    @"type": RecommendationTriggerType,

    pub const json_field_names = .{
        .data = "data",
        .id = "id",
        .recommendation_ids = "recommendationIds",
        .source = "source",
        .@"type" = "type",
    };
};
