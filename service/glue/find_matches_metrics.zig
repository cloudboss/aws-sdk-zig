const ColumnImportance = @import("column_importance.zig").ColumnImportance;
const ConfusionMatrix = @import("confusion_matrix.zig").ConfusionMatrix;

/// The evaluation metrics for the find matches algorithm. The quality of your
/// machine
/// learning transform is measured by getting your transform to predict some
/// matches and comparing
/// the results to known matches from the same dataset. The quality metrics are
/// based on a subset
/// of your data, so they are not precise.
pub const FindMatchesMetrics = struct {
    /// The area under the precision/recall curve (AUPRC) is a single number
    /// measuring the overall
    /// quality of the transform, that is independent of the choice made for
    /// precision vs. recall.
    /// Higher values indicate that you have a more attractive precision vs. recall
    /// tradeoff.
    ///
    /// For more information, see [Precision and
    /// recall](https://en.wikipedia.org/wiki/Precision_and_recall) in Wikipedia.
    area_under_pr_curve: ?f64,

    /// A list of `ColumnImportance` structures containing column importance
    /// metrics, sorted in order of descending importance.
    column_importances: ?[]const ColumnImportance,

    /// The confusion matrix shows you what your transform is predicting accurately
    /// and what types of errors it is making.
    ///
    /// For more information, see [Confusion
    /// matrix](https://en.wikipedia.org/wiki/Confusion_matrix) in Wikipedia.
    confusion_matrix: ?ConfusionMatrix,

    /// The maximum F1 metric indicates the transform's accuracy between 0 and 1,
    /// where 1 is the best accuracy.
    ///
    /// For more information, see [F1 score](https://en.wikipedia.org/wiki/F1_score)
    /// in Wikipedia.
    f1: ?f64,

    /// The precision metric indicates when often your transform is correct when it
    /// predicts a match. Specifically, it measures how well the transform finds
    /// true positives from the total true positives possible.
    ///
    /// For more information, see [Precision and
    /// recall](https://en.wikipedia.org/wiki/Precision_and_recall) in Wikipedia.
    precision: ?f64,

    /// The recall metric indicates that for an actual match, how often your
    /// transform predicts
    /// the match. Specifically, it measures how well the transform finds true
    /// positives from the
    /// total records in the source data.
    ///
    /// For more information, see [Precision and
    /// recall](https://en.wikipedia.org/wiki/Precision_and_recall) in Wikipedia.
    recall: ?f64,

    pub const json_field_names = .{
        .area_under_pr_curve = "AreaUnderPRCurve",
        .column_importances = "ColumnImportances",
        .confusion_matrix = "ConfusionMatrix",
        .f1 = "F1",
        .precision = "Precision",
        .recall = "Recall",
    };
};
