/// Recommendations that are provided to make an application more recovery
/// resilient.
pub const Recommendation = struct {
    /// Text of the recommendations that are provided to make an application more
    /// recovery resilient.
    recommendation_text: []const u8,

    pub const json_field_names = .{
        .recommendation_text = "RecommendationText",
    };
};
