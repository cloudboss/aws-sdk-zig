const ScoreConfidence = @import("score_confidence.zig").ScoreConfidence;

/// Provides information about the relevance score of content.
pub const ScoreAttributes = struct {
    /// The confidence level of the relevance score.
    score_confidence: ?ScoreConfidence = null,

    pub const json_field_names = .{
        .score_confidence = "scoreConfidence",
    };
};
