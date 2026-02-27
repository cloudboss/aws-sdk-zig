const DataSummary = @import("data_summary.zig").DataSummary;
const Document = @import("document.zig").Document;
const RelevanceLevel = @import("relevance_level.zig").RelevanceLevel;
const RecommendationType = @import("recommendation_type.zig").RecommendationType;

/// Information about the recommendation.
pub const RecommendationData = struct {
    /// Summary of the recommended content.
    data: ?DataSummary,

    /// The recommended document.
    document: ?Document,

    /// The identifier of the recommendation.
    recommendation_id: []const u8,

    /// The relevance level of the recommendation.
    relevance_level: ?RelevanceLevel,

    /// The relevance score of the recommendation.
    relevance_score: f64 = 0,

    /// The type of recommendation.
    type: ?RecommendationType,

    pub const json_field_names = .{
        .data = "data",
        .document = "document",
        .recommendation_id = "recommendationId",
        .relevance_level = "relevanceLevel",
        .relevance_score = "relevanceScore",
        .type = "type",
    };
};
