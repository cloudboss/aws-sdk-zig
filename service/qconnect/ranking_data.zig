const RelevanceLevel = @import("relevance_level.zig").RelevanceLevel;

/// Details about the source content ranking data.
pub const RankingData = struct {
    /// The relevance score of the content.
    relevance_level: ?RelevanceLevel,

    /// The relevance level of the recommendation.
    relevance_score: f64 = 0,

    pub const json_field_names = .{
        .relevance_level = "relevanceLevel",
        .relevance_score = "relevanceScore",
    };
};
