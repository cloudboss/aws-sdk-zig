const ScoreConfidence = @import("score_confidence.zig").ScoreConfidence;

/// Provides a relative ranking that indicates how confident Amazon Kendra is
/// that the
/// response is relevant to the query.
pub const ScoreAttributes = struct {
    /// A relative ranking for how relevant the response is to the query.
    score_confidence: ?ScoreConfidence,

    pub const json_field_names = .{
        .score_confidence = "ScoreConfidence",
    };
};
