/// Indicates the grouping recommendation you have accepted to include in your
/// application.
pub const AcceptGroupingRecommendationEntry = struct {
    /// Indicates the identifier of the grouping recommendation.
    grouping_recommendation_id: []const u8,

    pub const json_field_names = .{
        .grouping_recommendation_id = "groupingRecommendationId",
    };
};
