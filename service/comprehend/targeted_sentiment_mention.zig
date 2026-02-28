const MentionSentiment = @import("mention_sentiment.zig").MentionSentiment;
const TargetedSentimentEntityType = @import("targeted_sentiment_entity_type.zig").TargetedSentimentEntityType;

/// Information about one mention of an entity. The mention information includes
/// the location of the mention
/// in the text and the sentiment of the mention.
///
/// For more information about targeted sentiment, see [Targeted
/// sentiment](https://docs.aws.amazon.com/comprehend/latest/dg/how-targeted-sentiment.html) in the *Amazon Comprehend Developer Guide*.
pub const TargetedSentimentMention = struct {
    /// The offset into the document text where the mention begins.
    begin_offset: ?i32,

    /// The offset into the document text where the mention ends.
    end_offset: ?i32,

    /// The confidence that all the entities mentioned in the group relate to the
    /// same entity.
    group_score: ?f32,

    /// Contains the sentiment and sentiment score for the mention.
    mention_sentiment: ?MentionSentiment,

    /// Model confidence that the entity is relevant. Value range is zero to one,
    /// where one is highest confidence.
    score: ?f32,

    /// The text in the document that identifies the entity.
    text: ?[]const u8,

    /// The type of the entity. Amazon Comprehend supports a variety of [entity
    /// types](https://docs.aws.amazon.com/comprehend/latest/dg/how-targeted-sentiment.html#how-targeted-sentiment-entities).
    type: ?TargetedSentimentEntityType,

    pub const json_field_names = .{
        .begin_offset = "BeginOffset",
        .end_offset = "EndOffset",
        .group_score = "GroupScore",
        .mention_sentiment = "MentionSentiment",
        .score = "Score",
        .text = "Text",
        .type = "Type",
    };
};
