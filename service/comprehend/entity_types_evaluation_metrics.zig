/// Detailed information about the accuracy of an entity recognizer for a
/// specific entity
/// type.
pub const EntityTypesEvaluationMetrics = struct {
    /// A measure of how accurate the recognizer results are for a specific entity
    /// type in the
    /// test data. It is derived from the `Precision` and `Recall` values. The
    /// `F1Score` is the harmonic average of the two scores. The highest score is 1,
    /// and
    /// the worst score is 0.
    f1_score: ?f64 = null,

    /// A measure of the usefulness of the recognizer results for a specific entity
    /// type in the
    /// test data. High precision means that the recognizer returned substantially
    /// more relevant
    /// results than irrelevant ones.
    precision: ?f64 = null,

    /// A measure of how complete the recognizer results are for a specific entity
    /// type in the
    /// test data. High recall means that the recognizer returned most of the
    /// relevant results.
    recall: ?f64 = null,

    pub const json_field_names = .{
        .f1_score = "F1Score",
        .precision = "Precision",
        .recall = "Recall",
    };
};
