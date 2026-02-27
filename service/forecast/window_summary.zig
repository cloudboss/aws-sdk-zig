const EvaluationType = @import("evaluation_type.zig").EvaluationType;
const Metrics = @import("metrics.zig").Metrics;

/// The metrics for a time range within the evaluation portion of a dataset.
/// This object is
/// part of the EvaluationResult object.
///
/// The `TestWindowStart` and `TestWindowEnd` parameters are determined
/// by the `BackTestWindowOffset` parameter of the EvaluationParameters object.
pub const WindowSummary = struct {
    /// The type of evaluation.
    ///
    /// * `SUMMARY` - The average metrics across all windows.
    ///
    /// * `COMPUTED` - The metrics for the specified window.
    evaluation_type: ?EvaluationType,

    /// The number of data points within the window.
    item_count: ?i32,

    /// Provides metrics used to evaluate the performance of a predictor.
    metrics: ?Metrics,

    /// The timestamp that defines the end of the window.
    test_window_end: ?i64,

    /// The timestamp that defines the start of the window.
    test_window_start: ?i64,

    pub const json_field_names = .{
        .evaluation_type = "EvaluationType",
        .item_count = "ItemCount",
        .metrics = "Metrics",
        .test_window_end = "TestWindowEnd",
        .test_window_start = "TestWindowStart",
    };
};
