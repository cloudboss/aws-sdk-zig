const BaselineMetric = @import("baseline_metric.zig").BaselineMetric;

/// Metrics you can use as a baseline for comparison purposes. Use these metrics
/// when you interpret monitoring results for an auto predictor.
pub const PredictorBaseline = struct {
    /// The initial [accuracy
    /// metrics](https://docs.aws.amazon.com/forecast/latest/dg/metrics.html) for
    /// the predictor. Use these metrics as a baseline for comparison purposes as
    /// you
    /// use your predictor and the metrics change.
    baseline_metrics: ?[]const BaselineMetric = null,

    pub const json_field_names = .{
        .baseline_metrics = "BaselineMetrics",
    };
};
