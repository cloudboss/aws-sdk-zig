const AugmentedManifestsDocumentTypeFormat = @import("augmented_manifests_document_type_format.zig").AugmentedManifestsDocumentTypeFormat;

/// An augmented manifest file that provides training data for your custom
/// model.
/// An augmented manifest file is a labeled dataset that is produced by Amazon
/// SageMaker Ground Truth.
pub const DatasetAugmentedManifestsListItem = struct {
    /// The S3 prefix to the annotation files that are referred in the augmented
    /// manifest
    /// file.
    annotation_data_s3_uri: ?[]const u8,

    /// The JSON attribute that contains the annotations for your training
    /// documents. The number
    /// of attribute names that you specify depends on whether your augmented
    /// manifest file is the
    /// output of a single labeling job or a chained labeling job.
    ///
    /// If your file is the output of a single labeling job, specify the
    /// LabelAttributeName key
    /// that was used when the job was created in Ground Truth.
    ///
    /// If your file is the output of a chained labeling job, specify the
    /// LabelAttributeName key
    /// for one or more jobs in the chain. Each LabelAttributeName key provides the
    /// annotations from
    /// an individual job.
    attribute_names: []const []const u8,

    /// The type of augmented manifest. If you don't specify, the default is
    /// PlainTextDocument.
    ///
    /// `PLAIN_TEXT_DOCUMENT` A document type that represents any unicode text that
    /// is encoded in UTF-8.
    document_type: ?AugmentedManifestsDocumentTypeFormat,

    /// The Amazon S3 location of the augmented manifest file.
    s3_uri: []const u8,

    /// The S3 prefix to the source files (PDFs) that are referred to in the
    /// augmented manifest
    /// file.
    source_documents_s3_uri: ?[]const u8,

    pub const json_field_names = .{
        .annotation_data_s3_uri = "AnnotationDataS3Uri",
        .attribute_names = "AttributeNames",
        .document_type = "DocumentType",
        .s3_uri = "S3Uri",
        .source_documents_s3_uri = "SourceDocumentsS3Uri",
    };
};
