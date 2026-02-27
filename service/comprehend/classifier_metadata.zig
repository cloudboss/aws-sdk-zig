const ClassifierEvaluationMetrics = @import("classifier_evaluation_metrics.zig").ClassifierEvaluationMetrics;

/// Provides information about a document classifier.
pub const ClassifierMetadata = struct {
    /// Describes the result metrics for the test data associated with an
    /// documentation
    /// classifier.
    evaluation_metrics: ?ClassifierEvaluationMetrics,

    /// The number of labels in the input data.
    number_of_labels: ?i32,

    /// The number of documents in the input data that were used to test the
    /// classifier. Typically
    /// this is 10 to 20 percent of the input documents, up to 10,000 documents.
    number_of_test_documents: ?i32,

    /// The number of documents in the input data that were used to train the
    /// classifier.
    /// Typically this is 80 to 90 percent of the input documents.
    number_of_trained_documents: ?i32,

    pub const json_field_names = .{
        .evaluation_metrics = "EvaluationMetrics",
        .number_of_labels = "NumberOfLabels",
        .number_of_test_documents = "NumberOfTestDocuments",
        .number_of_trained_documents = "NumberOfTrainedDocuments",
    };
};
