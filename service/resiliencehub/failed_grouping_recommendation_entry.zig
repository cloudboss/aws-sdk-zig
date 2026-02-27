/// Indicates the accepted grouping recommendation whose implementation failed.
pub const FailedGroupingRecommendationEntry = struct {
    /// Indicates the error that occurred while implementing a grouping
    /// recommendation.
    error_message: []const u8,

    /// Indicates the identifier of the grouping recommendation.
    grouping_recommendation_id: []const u8,

    pub const json_field_names = .{
        .error_message = "errorMessage",
        .grouping_recommendation_id = "groupingRecommendationId",
    };
};
