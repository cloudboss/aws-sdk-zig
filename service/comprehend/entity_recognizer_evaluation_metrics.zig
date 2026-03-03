/// Detailed information about the accuracy of an entity recognizer.
pub const EntityRecognizerEvaluationMetrics = struct {
    /// A measure of how accurate the recognizer results are for the test data. It
    /// is derived from
    /// the `Precision` and `Recall` values. The `F1Score` is the
    /// harmonic average of the two scores. For plain text entity recognizer models,
    /// the range is 0 to 100,
    /// where 100 is the best score. For PDF/Word entity recognizer models, the
    /// range is 0 to 1,
    /// where 1 is the best score.
    f1_score: ?f64 = null,

    /// A measure of the usefulness of the recognizer results in the test data. High
    /// precision
    /// means that the recognizer returned substantially more relevant results than
    /// irrelevant ones.
    precision: ?f64 = null,

    /// A measure of how complete the recognizer results are for the test data. High
    /// recall means
    /// that the recognizer returned most of the relevant results.
    recall: ?f64 = null,

    pub const json_field_names = .{
        .f1_score = "F1Score",
        .precision = "Precision",
        .recall = "Recall",
    };
};
