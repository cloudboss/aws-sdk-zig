/// The list of recommendations for the insight.
pub const Recommendation = struct {
    /// The recommendation details to help resolve the performance issue. For
    /// example,
    /// `Investigate the following SQLs that contributed to 100% of the total DBLoad
    /// during that time period: sql-id`
    recommendation_description: ?[]const u8 = null,

    /// Detailed information about the recommendation, including steps to resolve
    /// the performance issue.
    recommendation_details: ?[]const u8 = null,

    /// The unique identifier for the recommendation.
    recommendation_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .recommendation_description = "RecommendationDescription",
        .recommendation_details = "RecommendationDetails",
        .recommendation_id = "RecommendationId",
    };
};
