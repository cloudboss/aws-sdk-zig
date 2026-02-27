const TargetedSentimentMention = @import("targeted_sentiment_mention.zig").TargetedSentimentMention;

/// Information about one of the entities found by targeted sentiment analysis.
///
/// For more information about targeted sentiment, see [Targeted
/// sentiment](https://docs.aws.amazon.com/comprehend/latest/dg/how-targeted-sentiment.html) in the *Amazon Comprehend Developer Guide*.
pub const TargetedSentimentEntity = struct {
    /// One or more index into the Mentions array that provides the best name for
    /// the entity group.
    descriptive_mention_index: ?[]const i32,

    /// An array of mentions of the entity in the document. The array represents a
    /// co-reference group.
    /// See [
    /// Co-reference
    /// group](https://docs.aws.amazon.com/comprehend/latest/dg/how-targeted-sentiment.html#how-targeted-sentiment-values) for an example.
    mentions: ?[]const TargetedSentimentMention,

    pub const json_field_names = .{
        .descriptive_mention_index = "DescriptiveMentionIndex",
        .mentions = "Mentions",
    };
};
