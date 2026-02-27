/// Describes the result metrics for the test data associated with an
/// documentation
/// classifier.
pub const ClassifierEvaluationMetrics = struct {
    /// The fraction of the labels that were correct recognized. It is computed by
    /// dividing the
    /// number of labels in the test documents that were correctly recognized by the
    /// total number of
    /// labels in the test documents.
    accuracy: ?f64,

    /// A measure of how accurate the classifier results are for the test data. It
    /// is derived from
    /// the `Precision` and `Recall` values. The `F1Score` is the
    /// harmonic average of the two scores. The highest score is 1, and the worst
    /// score is 0.
    f1_score: ?f64,

    /// Indicates the fraction of labels that are incorrectly predicted. Also seen
    /// as the fraction
    /// of wrong labels compared to the total number of labels. Scores closer to
    /// zero are
    /// better.
    hamming_loss: ?f64,

    /// A measure of how accurate the classifier results are for the test data. It
    /// is a
    /// combination of the `Micro Precision` and `Micro Recall` values. The
    /// `Micro F1Score` is the harmonic mean of the two scores. The highest score is
    /// 1,
    /// and the worst score is 0.
    micro_f1_score: ?f64,

    /// A measure of the usefulness of the recognizer results in the test data. High
    /// precision
    /// means that the recognizer returned substantially more relevant results than
    /// irrelevant ones.
    /// Unlike the Precision metric which comes from averaging the precision of all
    /// available labels,
    /// this is based on the overall score of all precision scores added together.
    micro_precision: ?f64,

    /// A measure of how complete the classifier results are for the test data. High
    /// recall means
    /// that the classifier returned most of the relevant results. Specifically,
    /// this indicates how
    /// many of the correct categories in the text that the model can predict. It is
    /// a percentage of
    /// correct categories in the text that can found. Instead of averaging the
    /// recall scores of all
    /// labels (as with Recall), micro Recall is based on the overall score of all
    /// recall scores added
    /// together.
    micro_recall: ?f64,

    /// A measure of the usefulness of the classifier results in the test data. High
    /// precision
    /// means that the classifier returned substantially more relevant results than
    /// irrelevant
    /// ones.
    precision: ?f64,

    /// A measure of how complete the classifier results are for the test data. High
    /// recall means
    /// that the classifier returned most of the relevant results.
    recall: ?f64,

    pub const json_field_names = .{
        .accuracy = "Accuracy",
        .f1_score = "F1Score",
        .hamming_loss = "HammingLoss",
        .micro_f1_score = "MicroF1Score",
        .micro_precision = "MicroPrecision",
        .micro_recall = "MicroRecall",
        .precision = "Precision",
        .recall = "Recall",
    };
};
