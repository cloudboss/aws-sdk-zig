/// Describes the level of confidence that Amazon Comprehend has in the accuracy
/// of its
/// detection of sentiments.
pub const SentimentScore = struct {
    /// The level of confidence that Amazon Comprehend has in the accuracy of its
    /// detection of
    /// the `MIXED` sentiment.
    mixed: ?f32,

    /// The level of confidence that Amazon Comprehend has in the accuracy of its
    /// detection of
    /// the `NEGATIVE` sentiment.
    negative: ?f32,

    /// The level of confidence that Amazon Comprehend has in the accuracy of its
    /// detection of
    /// the `NEUTRAL` sentiment.
    neutral: ?f32,

    /// The level of confidence that Amazon Comprehend has in the accuracy of its
    /// detection of
    /// the `POSITIVE` sentiment.
    positive: ?f32,

    pub const json_field_names = .{
        .mixed = "Mixed",
        .negative = "Negative",
        .neutral = "Neutral",
        .positive = "Positive",
    };
};
