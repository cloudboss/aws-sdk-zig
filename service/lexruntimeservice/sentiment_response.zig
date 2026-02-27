/// The sentiment expressed in an utterance.
///
/// When the bot is configured to send utterances to Amazon Comprehend for
/// sentiment analysis, this field structure contains the result of the
/// analysis.
pub const SentimentResponse = struct {
    /// The inferred sentiment that Amazon Comprehend has the highest
    /// confidence in.
    sentiment_label: ?[]const u8,

    /// The likelihood that the sentiment was correctly inferred.
    sentiment_score: ?[]const u8,

    pub const json_field_names = .{
        .sentiment_label = "sentimentLabel",
        .sentiment_score = "sentimentScore",
    };
};
