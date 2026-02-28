const EntityTypesEvaluationMetrics = @import("entity_types_evaluation_metrics.zig").EntityTypesEvaluationMetrics;

/// Individual item from the list of entity types in the metadata of an entity
/// recognizer.
pub const EntityRecognizerMetadataEntityTypesListItem = struct {
    /// Detailed information about the accuracy of the entity recognizer for a
    /// specific item on
    /// the list of entity types.
    evaluation_metrics: ?EntityTypesEvaluationMetrics,

    /// Indicates the number of times the given entity type was seen in the training
    /// data.
    number_of_train_mentions: ?i32,

    /// Type of entity from the list of entity types in the metadata of an entity
    /// recognizer.
    type: ?[]const u8,

    pub const json_field_names = .{
        .evaluation_metrics = "EvaluationMetrics",
        .number_of_train_mentions = "NumberOfTrainMentions",
        .type = "Type",
    };
};
