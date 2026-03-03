const DatasetAugmentedManifestsListItem = @import("dataset_augmented_manifests_list_item.zig").DatasetAugmentedManifestsListItem;
const DatasetDataFormat = @import("dataset_data_format.zig").DatasetDataFormat;
const DatasetDocumentClassifierInputDataConfig = @import("dataset_document_classifier_input_data_config.zig").DatasetDocumentClassifierInputDataConfig;
const DatasetEntityRecognizerInputDataConfig = @import("dataset_entity_recognizer_input_data_config.zig").DatasetEntityRecognizerInputDataConfig;

/// Specifies the format and location of the input data for the dataset.
pub const DatasetInputDataConfig = struct {
    /// A list of augmented manifest files that provide training data for your
    /// custom model. An
    /// augmented manifest file is a labeled dataset that is produced by Amazon
    /// SageMaker Ground
    /// Truth.
    augmented_manifests: ?[]const DatasetAugmentedManifestsListItem = null,

    /// `COMPREHEND_CSV`: The data format is a two-column CSV file, where the
    /// first column contains labels and the second column contains documents.
    ///
    /// `AUGMENTED_MANIFEST`: The data format
    data_format: ?DatasetDataFormat = null,

    /// The input properties for training a document classifier model.
    ///
    /// For more information on how the input file is formatted, see [Preparing
    /// training
    /// data](https://docs.aws.amazon.com/comprehend/latest/dg/prep-classifier-data.html)
    /// in the Comprehend Developer Guide.
    document_classifier_input_data_config: ?DatasetDocumentClassifierInputDataConfig = null,

    /// The input properties for training an entity recognizer model.
    entity_recognizer_input_data_config: ?DatasetEntityRecognizerInputDataConfig = null,

    pub const json_field_names = .{
        .augmented_manifests = "AugmentedManifests",
        .data_format = "DataFormat",
        .document_classifier_input_data_config = "DocumentClassifierInputDataConfig",
        .entity_recognizer_input_data_config = "EntityRecognizerInputDataConfig",
    };
};
