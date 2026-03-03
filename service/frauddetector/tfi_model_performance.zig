const UncertaintyRange = @import("uncertainty_range.zig").UncertaintyRange;

/// The Transaction Fraud Insights (TFI) model performance score.
pub const TFIModelPerformance = struct {
    /// The area under the curve (auc). This summarizes the total positive rate
    /// (tpr) and false positive rate (FPR) across all possible model score
    /// thresholds.
    auc: ?f32 = null,

    /// Indicates the range of area under curve (auc) expected from the TFI model. A
    /// range greater than 0.1 indicates higher model uncertainity.
    uncertainty_range: ?UncertaintyRange = null,

    pub const json_field_names = .{
        .auc = "auc",
        .uncertainty_range = "uncertaintyRange",
    };
};
