const TargetedSentimentEntity = @import("targeted_sentiment_entity.zig").TargetedSentimentEntity;

/// Analysis results for one of the documents in the batch.
pub const BatchDetectTargetedSentimentItemResult = struct {
    /// An array of targeted sentiment entities.
    entities: ?[]const TargetedSentimentEntity,

    /// The zero-based index of this result in the input list.
    index: ?i32,

    pub const json_field_names = .{
        .entities = "Entities",
        .index = "Index",
    };
};
