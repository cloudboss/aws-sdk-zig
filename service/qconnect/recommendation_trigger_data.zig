const QueryRecommendationTriggerData = @import("query_recommendation_trigger_data.zig").QueryRecommendationTriggerData;

/// A union type containing information related to the trigger.
pub const RecommendationTriggerData = union(enum) {
    /// Data associated with the QUERY RecommendationTriggerType.
    query: ?QueryRecommendationTriggerData,

    pub const json_field_names = .{
        .query = "query",
    };
};
