const SentimentType = @import("sentiment_type.zig").SentimentType;
const SentimentScore = @import("sentiment_score.zig").SentimentScore;

/// Contains the sentiment and sentiment score for one mention of an entity.
///
/// For more information about targeted sentiment, see [Targeted
/// sentiment](https://docs.aws.amazon.com/comprehend/latest/dg/how-targeted-sentiment.html) in the *Amazon Comprehend Developer Guide*.
pub const MentionSentiment = struct {
    /// The sentiment of the mention.
    sentiment: ?SentimentType = null,

    sentiment_score: ?SentimentScore = null,

    pub const json_field_names = .{
        .sentiment = "Sentiment",
        .sentiment_score = "SentimentScore",
    };
};
