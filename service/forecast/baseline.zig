const PredictorBaseline = @import("predictor_baseline.zig").PredictorBaseline;

/// Metrics you can use as a baseline for comparison purposes. Use these metrics
/// when you interpret monitoring results for an auto predictor.
pub const Baseline = struct {
    /// The initial [accuracy
    /// metrics](https://docs.aws.amazon.com/forecast/latest/dg/metrics.html) for
    /// the predictor you are monitoring. Use these metrics as a baseline for
    /// comparison purposes as you
    /// use your predictor and the metrics change.
    predictor_baseline: ?PredictorBaseline,

    pub const json_field_names = .{
        .predictor_baseline = "PredictorBaseline",
    };
};
