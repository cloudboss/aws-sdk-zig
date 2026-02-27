/// Provides a score that indicates the confidence that Amazon Lex V2 has that
/// an intent is the one that satisfies the user's intent.
pub const ConfidenceScore = struct {
    /// A score that indicates how confident Amazon Lex V2 is that an intent
    /// satisfies the user's intent. Ranges between 0.00 and 1.00. Higher
    /// scores indicate higher confidence.
    score: f64 = 0,

    pub const json_field_names = .{
        .score = "score",
    };
};
