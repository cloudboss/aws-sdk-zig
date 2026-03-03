const SentimentType = @import("sentiment_type.zig").SentimentType;
const SentimentScore = @import("sentiment_score.zig").SentimentScore;

/// Provides information about the sentiment expressed in a user's
/// response in a conversation. Sentiments are determined using Amazon
/// Comprehend. Sentiments are only returned if they are enabled for the
/// bot.
///
/// For more information, see [
/// Determine Sentiment
/// ](https://docs.aws.amazon.com/comprehend/latest/dg/how-sentiment.html) in
/// the *Amazon Comprehend
/// developer guide*.
pub const SentimentResponse = struct {
    /// The overall sentiment expressed in the user's response. This is the
    /// sentiment most likely expressed by the user based on the analysis by
    /// Amazon Comprehend.
    sentiment: ?SentimentType = null,

    sentiment_score: ?SentimentScore = null,

    pub const json_field_names = .{
        .sentiment = "sentiment",
        .sentiment_score = "sentimentScore",
    };
};
