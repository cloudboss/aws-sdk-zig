const DatasetEntityRecognizerAnnotations = @import("dataset_entity_recognizer_annotations.zig").DatasetEntityRecognizerAnnotations;
const DatasetEntityRecognizerDocuments = @import("dataset_entity_recognizer_documents.zig").DatasetEntityRecognizerDocuments;
const DatasetEntityRecognizerEntityList = @import("dataset_entity_recognizer_entity_list.zig").DatasetEntityRecognizerEntityList;

/// Specifies the format and location of the input data. You must provide either
/// the
/// `Annotations` parameter or the `EntityList` parameter.
pub const DatasetEntityRecognizerInputDataConfig = struct {
    /// The S3 location of the annotation documents for your custom entity
    /// recognizer.
    annotations: ?DatasetEntityRecognizerAnnotations = null,

    /// The format and location of the training documents for your custom entity
    /// recognizer.
    documents: DatasetEntityRecognizerDocuments,

    /// The S3 location of the entity list for your custom entity recognizer.
    entity_list: ?DatasetEntityRecognizerEntityList = null,

    pub const json_field_names = .{
        .annotations = "Annotations",
        .documents = "Documents",
        .entity_list = "EntityList",
    };
};
