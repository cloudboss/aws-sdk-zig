const AutoMLAlgorithm = @import("auto_ml_algorithm.zig").AutoMLAlgorithm;

/// The selection of algorithms trained on your dataset to generate the model
/// candidates for an Autopilot job.
pub const AutoMLAlgorithmConfig = struct {
    /// The selection of algorithms trained on your dataset to generate the model
    /// candidates for an Autopilot job.
    ///
    /// * **For the tabular problem type `TabularJobConfig`:**
    ///
    /// Selected algorithms must belong to the list corresponding to the training
    /// mode set in
    /// [AutoMLJobConfig.Mode](https://docs.aws.amazon.com/sagemaker/latest/APIReference/API_AutoMLJobConfig.html#sagemaker-Type-AutoMLJobConfig-Mode) (`ENSEMBLING` or `HYPERPARAMETER_TUNING`). Choose a minimum of 1 algorithm.
    ///
    /// * In `ENSEMBLING` mode:
    ///
    /// * "catboost"
    /// * "extra-trees"
    /// * "fastai"
    /// * "lightgbm"
    /// * "linear-learner"
    /// * "nn-torch"
    /// * "randomforest"
    /// * "xgboost"
    ///
    /// * In `HYPERPARAMETER_TUNING` mode:
    ///
    /// * "linear-learner"
    /// * "mlp"
    /// * "xgboost"
    ///
    /// * **For the time-series forecasting problem type
    ///   `TimeSeriesForecastingJobConfig`:**
    ///
    /// * Choose your algorithms from this list.
    ///
    /// * "cnn-qr"
    /// * "deepar"
    /// * "prophet"
    /// * "arima"
    /// * "npts"
    /// * "ets"
    auto_ml_algorithms: []const AutoMLAlgorithm,

    pub const json_field_names = .{
        .auto_ml_algorithms = "AutoMLAlgorithms",
    };
};
