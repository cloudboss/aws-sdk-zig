/// The weighted loss value for a quantile. This object is part of the Metrics
/// object.
pub const WeightedQuantileLoss = struct {
    /// The difference between the predicted value and the actual value over the
    /// quantile,
    /// weighted (normalized) by dividing by the sum over all quantiles.
    loss_value: ?f64 = null,

    /// The quantile. Quantiles divide a probability distribution into regions of
    /// equal
    /// probability. For example, if the distribution was divided into 5 regions of
    /// equal probability,
    /// the quantiles would be 0.2, 0.4, 0.6, and 0.8.
    quantile: ?f64 = null,

    pub const json_field_names = .{
        .loss_value = "LossValue",
        .quantile = "Quantile",
    };
};
