/// The individual sentiment responses for the utterance.
pub const SentimentScore = struct {
    /// The level of confidence that Amazon Comprehend has in the accuracy
    /// of its detection of the `MIXED` sentiment.
    mixed: f64 = 0,

    /// The level of confidence that Amazon Comprehend has in the accuracy
    /// of its detection of the `NEGATIVE` sentiment.
    negative: f64 = 0,

    /// The level of confidence that Amazon Comprehend has in the accuracy
    /// of its detection of the `NEUTRAL` sentiment.
    neutral: f64 = 0,

    /// The level of confidence that Amazon Comprehend has in the accuracy
    /// of its detection of the `POSITIVE` sentiment.
    positive: f64 = 0,

    pub const json_field_names = .{
        .mixed = "mixed",
        .negative = "negative",
        .neutral = "neutral",
        .positive = "positive",
    };
};
