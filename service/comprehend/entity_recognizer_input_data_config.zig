const EntityRecognizerAnnotations = @import("entity_recognizer_annotations.zig").EntityRecognizerAnnotations;
const AugmentedManifestsListItem = @import("augmented_manifests_list_item.zig").AugmentedManifestsListItem;
const EntityRecognizerDataFormat = @import("entity_recognizer_data_format.zig").EntityRecognizerDataFormat;
const EntityRecognizerDocuments = @import("entity_recognizer_documents.zig").EntityRecognizerDocuments;
const EntityRecognizerEntityList = @import("entity_recognizer_entity_list.zig").EntityRecognizerEntityList;
const EntityTypesListItem = @import("entity_types_list_item.zig").EntityTypesListItem;

/// Specifies the format and location of the input data.
pub const EntityRecognizerInputDataConfig = struct {
    /// The S3 location of the CSV file that annotates your training documents.
    annotations: ?EntityRecognizerAnnotations = null,

    /// A list of augmented manifest files that provide training data for your
    /// custom model. An
    /// augmented manifest file is a labeled dataset that is produced by Amazon
    /// SageMaker Ground
    /// Truth.
    ///
    /// This parameter is required if you set `DataFormat` to
    /// `AUGMENTED_MANIFEST`.
    augmented_manifests: ?[]const AugmentedManifestsListItem = null,

    /// The format of your training data:
    ///
    /// * `COMPREHEND_CSV`: A CSV file that supplements your training documents. The
    /// CSV file contains information about the custom entities that your trained
    /// model will
    /// detect. The required format of the file depends on whether you are providing
    /// annotations
    /// or an entity list.
    ///
    /// If you use this value, you must provide your CSV file by using either the
    /// `Annotations` or `EntityList` parameters. You must provide your
    /// training documents by using the `Documents` parameter.
    ///
    /// * `AUGMENTED_MANIFEST`: A labeled dataset that is produced by Amazon
    /// SageMaker Ground Truth. This file is in JSON lines format. Each line is a
    /// complete JSON
    /// object that contains a training document and its labels. Each label
    /// annotates a named
    /// entity in the training document.
    ///
    /// If you use this value, you must provide the `AugmentedManifests` parameter
    /// in your request.
    ///
    /// If you don't specify a value, Amazon Comprehend uses `COMPREHEND_CSV` as the
    /// default.
    data_format: ?EntityRecognizerDataFormat = null,

    /// The S3 location of the folder that contains the training documents for your
    /// custom entity
    /// recognizer.
    ///
    /// This parameter is required if you set `DataFormat` to
    /// `COMPREHEND_CSV`.
    documents: ?EntityRecognizerDocuments = null,

    /// The S3 location of the CSV file that has the entity list for your custom
    /// entity
    /// recognizer.
    entity_list: ?EntityRecognizerEntityList = null,

    /// The entity types in the labeled training data that Amazon Comprehend uses to
    /// train the
    /// custom entity recognizer. Any entity types that you don't specify are
    /// ignored.
    ///
    /// A maximum of 25 entity types can be used at one time to train an entity
    /// recognizer. Entity
    /// types must not contain the following invalid characters: \n (line break),
    /// \\n (escaped line
    /// break), \r (carriage return), \\r (escaped carriage return), \t (tab), \\t
    /// (escaped tab),
    /// space, and , (comma).
    entity_types: []const EntityTypesListItem,

    pub const json_field_names = .{
        .annotations = "Annotations",
        .augmented_manifests = "AugmentedManifests",
        .data_format = "DataFormat",
        .documents = "Documents",
        .entity_list = "EntityList",
        .entity_types = "EntityTypes",
    };
};
