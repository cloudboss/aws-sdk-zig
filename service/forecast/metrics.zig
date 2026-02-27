const ErrorMetric = @import("error_metric.zig").ErrorMetric;
const WeightedQuantileLoss = @import("weighted_quantile_loss.zig").WeightedQuantileLoss;

/// Provides metrics that are used to evaluate the performance of a predictor.
/// This object is
/// part of the WindowSummary object.
pub const Metrics = struct {
    /// The average value of all weighted quantile losses.
    average_weighted_quantile_loss: ?f64,

    /// Provides detailed error metrics for each forecast type. Metrics include
    /// root-mean
    /// square-error (RMSE), mean absolute percentage error (MAPE), mean absolute
    /// scaled error (MASE),
    /// and weighted average percentage error (WAPE).
    error_metrics: ?[]const ErrorMetric,

    /// The root-mean-square error (RMSE).
    rmse: ?f64,

    /// An array of weighted quantile losses. Quantiles divide a probability
    /// distribution into
    /// regions of equal probability. The distribution in this case is the loss
    /// function.
    weighted_quantile_losses: ?[]const WeightedQuantileLoss,

    pub const json_field_names = .{
        .average_weighted_quantile_loss = "AverageWeightedQuantileLoss",
        .error_metrics = "ErrorMetrics",
        .rmse = "RMSE",
        .weighted_quantile_losses = "WeightedQuantileLosses",
    };
};
