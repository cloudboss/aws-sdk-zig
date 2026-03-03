const TestWindowSummary = @import("test_window_summary.zig").TestWindowSummary;

/// The algorithm used to perform a backtest and the status of those tests.
pub const PredictorExecution = struct {
    /// The ARN of the algorithm used to test the predictor.
    algorithm_arn: ?[]const u8 = null,

    /// An array of test windows used to evaluate the algorithm. The
    /// `NumberOfBacktestWindows` from the
    /// object determines the number of windows in the array.
    test_windows: ?[]const TestWindowSummary = null,

    pub const json_field_names = .{
        .algorithm_arn = "AlgorithmArn",
        .test_windows = "TestWindows",
    };
};
