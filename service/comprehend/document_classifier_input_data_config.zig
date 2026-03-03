const AugmentedManifestsListItem = @import("augmented_manifests_list_item.zig").AugmentedManifestsListItem;
const DocumentClassifierDataFormat = @import("document_classifier_data_format.zig").DocumentClassifierDataFormat;
const DocumentReaderConfig = @import("document_reader_config.zig").DocumentReaderConfig;
const DocumentClassifierDocuments = @import("document_classifier_documents.zig").DocumentClassifierDocuments;
const DocumentClassifierDocumentTypeFormat = @import("document_classifier_document_type_format.zig").DocumentClassifierDocumentTypeFormat;

/// The input properties for training a document classifier.
///
/// For more information on how the input file is formatted, see
/// [Preparing training
/// data](https://docs.aws.amazon.com/comprehend/latest/dg/prep-classifier-data.html) in the Comprehend Developer Guide.
pub const DocumentClassifierInputDataConfig = struct {
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
    /// * `COMPREHEND_CSV`: A two-column CSV file, where labels are provided in the
    /// first column, and documents are provided in the second. If you use this
    /// value, you must
    /// provide the `S3Uri` parameter in your request.
    ///
    /// * `AUGMENTED_MANIFEST`: A labeled dataset that is produced by Amazon
    /// SageMaker Ground Truth. This file is in JSON lines format. Each line is a
    /// complete JSON
    /// object that contains a training document and its associated labels.
    ///
    /// If you use this value, you must provide the `AugmentedManifests` parameter
    /// in your request.
    ///
    /// If you don't specify a value, Amazon Comprehend uses `COMPREHEND_CSV` as the
    /// default.
    data_format: ?DocumentClassifierDataFormat = null,

    document_reader_config: ?DocumentReaderConfig = null,

    /// The S3 location of the training documents.
    /// This parameter is required in a request to create a native document model.
    documents: ?DocumentClassifierDocuments = null,

    /// The type of input documents for training the model. Provide plain-text
    /// documents to create a plain-text model, and
    /// provide semi-structured documents to create a native document model.
    document_type: ?DocumentClassifierDocumentTypeFormat = null,

    /// Indicates the delimiter used to separate each label for training a
    /// multi-label classifier.
    /// The default delimiter between labels is a pipe (|). You can use a different
    /// character as a
    /// delimiter (if it's an allowed character) by specifying it under Delimiter
    /// for labels. If the
    /// training documents use a delimiter other than the default or the delimiter
    /// you specify, the
    /// labels on that line will be combined to make a single unique label, such as
    /// LABELLABELLABEL.
    label_delimiter: ?[]const u8 = null,

    /// The Amazon S3 URI for the input data. The S3 bucket must be in the same
    /// Region as the API
    /// endpoint that you are calling. The URI can point to a single input file or
    /// it can provide the
    /// prefix for a collection of input files.
    ///
    /// For example, if you use the URI `S3://bucketName/prefix`, if the prefix is a
    /// single file, Amazon Comprehend uses that file as input. If more than one
    /// file begins with the
    /// prefix, Amazon Comprehend uses all of them as input.
    ///
    /// This parameter is required if you set `DataFormat` to
    /// `COMPREHEND_CSV`.
    s3_uri: ?[]const u8 = null,

    /// This specifies the Amazon S3 location that contains the test annotations for
    /// the document classifier.
    /// The URI must be in the same Amazon Web Services Region as the API endpoint
    /// that you are calling.
    test_s3_uri: ?[]const u8 = null,

    pub const json_field_names = .{
        .augmented_manifests = "AugmentedManifests",
        .data_format = "DataFormat",
        .document_reader_config = "DocumentReaderConfig",
        .documents = "Documents",
        .document_type = "DocumentType",
        .label_delimiter = "LabelDelimiter",
        .s3_uri = "S3Uri",
        .test_s3_uri = "TestS3Uri",
    };
};
