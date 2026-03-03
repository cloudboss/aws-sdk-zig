const WindowSummary = @import("window_summary.zig").WindowSummary;

/// The results of evaluating an algorithm. Returned as part of the
/// GetAccuracyMetrics response.
pub const EvaluationResult = struct {
    /// The Amazon Resource Name (ARN) of the algorithm that was evaluated.
    algorithm_arn: ?[]const u8 = null,

    /// The array of test windows used for evaluating the algorithm. The
    /// `NumberOfBacktestWindows` from the EvaluationParameters object
    /// determines the number of windows in the array.
    test_windows: ?[]const WindowSummary = null,

    pub const json_field_names = .{
        .algorithm_arn = "AlgorithmArn",
        .test_windows = "TestWindows",
    };
};
