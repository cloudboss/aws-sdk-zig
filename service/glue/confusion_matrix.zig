/// The confusion matrix shows you what your transform is predicting accurately
/// and what types of errors it is making.
///
/// For more information, see [Confusion
/// matrix](https://en.wikipedia.org/wiki/Confusion_matrix) in Wikipedia.
pub const ConfusionMatrix = struct {
    /// The number of matches in the data that the transform didn't find, in the
    /// confusion matrix for your transform.
    num_false_negatives: ?i64 = null,

    /// The number of nonmatches in the data that the transform incorrectly
    /// classified as a match,
    /// in the confusion matrix for your transform.
    num_false_positives: ?i64 = null,

    /// The number of nonmatches in the data that the transform correctly rejected,
    /// in the
    /// confusion matrix for your transform.
    num_true_negatives: ?i64 = null,

    /// The number of matches in the data that the transform correctly found, in the
    /// confusion matrix for your transform.
    num_true_positives: ?i64 = null,

    pub const json_field_names = .{
        .num_false_negatives = "NumFalseNegatives",
        .num_false_positives = "NumFalsePositives",
        .num_true_negatives = "NumTrueNegatives",
        .num_true_positives = "NumTruePositives",
    };
};
