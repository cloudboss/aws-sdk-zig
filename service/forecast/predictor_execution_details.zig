const PredictorExecution = @import("predictor_execution.zig").PredictorExecution;

/// Contains details on the backtests performed to evaluate the accuracy of the
/// predictor. The
/// tests are returned in descending order of accuracy, with the most accurate
/// backtest appearing
/// first. You specify the number of backtests to perform when you call the
/// operation.
pub const PredictorExecutionDetails = struct {
    /// An array of the backtests performed to evaluate the accuracy of the
    /// predictor against a
    /// particular algorithm. The `NumberOfBacktestWindows` from the object
    /// determines the number of windows in the
    /// array.
    predictor_executions: ?[]const PredictorExecution,

    pub const json_field_names = .{
        .predictor_executions = "PredictorExecutions",
    };
};
