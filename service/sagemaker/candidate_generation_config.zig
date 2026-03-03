const AutoMLAlgorithmConfig = @import("auto_ml_algorithm_config.zig").AutoMLAlgorithmConfig;

/// Stores the configuration information for how model candidates are generated
/// using an AutoML job V2.
pub const CandidateGenerationConfig = struct {
    /// Your Autopilot job trains a default set of algorithms on your dataset. For
    /// tabular and time-series data, you can customize the algorithm list by
    /// selecting a subset of algorithms for your problem type.
    ///
    /// `AlgorithmsConfig` stores the customized selection of algorithms to train on
    /// your data.
    ///
    /// * **For the tabular problem type `TabularJobConfig`,** the list of available
    ///   algorithms to choose from depends on the training mode set in [
    ///   `AutoMLJobConfig.Mode`
    ///   ](https://docs.aws.amazon.com/sagemaker/latest/APIReference/API_AutoMLJobConfig.html).
    ///
    /// * `AlgorithmsConfig` should not be set when the training mode
    ///   `AutoMLJobConfig.Mode` is set to `AUTO`.
    /// * When `AlgorithmsConfig` is provided, one `AutoMLAlgorithms` attribute must
    ///   be set and one only.
    ///
    /// If the list of algorithms provided as values for `AutoMLAlgorithms` is
    /// empty, `CandidateGenerationConfig` uses the full set of algorithms for the
    /// given training mode.
    /// * When `AlgorithmsConfig` is not provided, `CandidateGenerationConfig` uses
    ///   the full set of algorithms for the given training mode.
    ///
    /// For the list of all algorithms per training mode, see [
    /// AlgorithmConfig](https://docs.aws.amazon.com/sagemaker/latest/APIReference/API_AutoMLAlgorithmConfig.html).
    ///
    /// For more information on each algorithm, see the [Algorithm
    /// support](https://docs.aws.amazon.com/sagemaker/latest/dg/autopilot-model-support-validation.html#autopilot-algorithm-support) section in the Autopilot developer guide.
    /// * **For the time-series forecasting problem type
    ///   `TimeSeriesForecastingJobConfig`,** choose your algorithms from the list
    ///   provided in [
    ///   AlgorithmConfig](https://docs.aws.amazon.com/sagemaker/latest/APIReference/API_AutoMLAlgorithmConfig.html).
    ///
    /// For more information on each algorithm, see the [Algorithms support for
    /// time-series
    /// forecasting](https://docs.aws.amazon.com/sagemaker/latest/dg/timeseries-forecasting-algorithms.html) section in the Autopilot developer guide.
    ///
    /// * When `AlgorithmsConfig` is provided, one `AutoMLAlgorithms` attribute must
    ///   be set and one only.
    ///
    /// If the list of algorithms provided as values for `AutoMLAlgorithms` is
    /// empty, `CandidateGenerationConfig` uses the full set of algorithms for
    /// time-series forecasting.
    /// * When `AlgorithmsConfig` is not provided, `CandidateGenerationConfig` uses
    ///   the full set of algorithms for time-series forecasting.
    algorithms_config: ?[]const AutoMLAlgorithmConfig = null,

    pub const json_field_names = .{
        .algorithms_config = "AlgorithmsConfig",
    };
};
