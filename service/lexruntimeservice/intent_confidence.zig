/// Provides a score that indicates the confidence that Amazon Lex has that an
/// intent is the one that satisfies the user's intent.
pub const IntentConfidence = struct {
    /// A score that indicates how confident Amazon Lex is that an intent satisfies
    /// the user's intent. Ranges between 0.00 and 1.00. Higher scores indicate
    /// higher confidence.
    score: f64 = 0,

    pub const json_field_names = .{
        .score = "score",
    };
};
