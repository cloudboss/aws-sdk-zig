const SentimentType = @import("sentiment_type.zig").SentimentType;
const SentimentScore = @import("sentiment_score.zig").SentimentScore;

/// The result of calling the operation. The
/// operation returns one object for each document that is successfully
/// processed by the
/// operation.
pub const BatchDetectSentimentItemResult = struct {
    /// The zero-based index of the document in the input list.
    index: ?i32,

    /// The sentiment detected in the document.
    sentiment: ?SentimentType,

    /// The level of confidence that Amazon Comprehend has in the accuracy of its
    /// sentiment
    /// detection.
    sentiment_score: ?SentimentScore,

    pub const json_field_names = .{
        .index = "Index",
        .sentiment = "Sentiment",
        .sentiment_score = "SentimentScore",
    };
};
