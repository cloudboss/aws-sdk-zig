/// Determines whether Amazon Lex will use Amazon Comprehend to detect the
/// sentiment of
/// user utterances.
pub const SentimentAnalysisSettings = struct {
    /// Sets whether Amazon Lex uses Amazon Comprehend to detect the sentiment of
    /// user
    /// utterances.
    detect_sentiment: bool = false,

    pub const json_field_names = .{
        .detect_sentiment = "detectSentiment",
    };
};
