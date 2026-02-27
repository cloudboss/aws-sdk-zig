pub const OptimizationMetric = enum {
    wape,
    rmse,
    average_weighted_quantile_loss,
    mase,
    mape,

    pub const json_field_names = .{
        .wape = "WAPE",
        .rmse = "RMSE",
        .average_weighted_quantile_loss = "AverageWeightedQuantileLoss",
        .mase = "MASE",
        .mape = "MAPE",
    };
};
