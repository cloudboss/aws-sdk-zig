const EntityRecognizerMetadataEntityTypesListItem = @import("entity_recognizer_metadata_entity_types_list_item.zig").EntityRecognizerMetadataEntityTypesListItem;
const EntityRecognizerEvaluationMetrics = @import("entity_recognizer_evaluation_metrics.zig").EntityRecognizerEvaluationMetrics;

/// Detailed information about an entity recognizer.
pub const EntityRecognizerMetadata = struct {
    /// Entity types from the metadata of an entity recognizer.
    entity_types: ?[]const EntityRecognizerMetadataEntityTypesListItem,

    /// Detailed information about the accuracy of an entity recognizer.
    evaluation_metrics: ?EntityRecognizerEvaluationMetrics,

    /// The number of documents in the input data that were used to test the entity
    /// recognizer.
    /// Typically this is 10 to 20 percent of the input documents.
    number_of_test_documents: ?i32,

    /// The number of documents in the input data that were used to train the entity
    /// recognizer.
    /// Typically this is 80 to 90 percent of the input documents.
    number_of_trained_documents: ?i32,

    pub const json_field_names = .{
        .entity_types = "EntityTypes",
        .evaluation_metrics = "EvaluationMetrics",
        .number_of_test_documents = "NumberOfTestDocuments",
        .number_of_trained_documents = "NumberOfTrainedDocuments",
    };
};
