const HyperbandStrategyConfig = @import("hyperband_strategy_config.zig").HyperbandStrategyConfig;

/// The configuration for a training job launched by a hyperparameter tuning
/// job. Choose `Bayesian` for Bayesian optimization, and `Random` for random
/// search optimization. For more advanced use cases, use `Hyperband`, which
/// evaluates objective metrics for training jobs after every epoch. For more
/// information about strategies, see [How Hyperparameter Tuning
/// Works](https://docs.aws.amazon.com/sagemaker/latest/dg/automatic-model-tuning-how-it-works.html).
pub const HyperParameterTuningJobStrategyConfig = struct {
    /// The configuration for the object that specifies the `Hyperband` strategy.
    /// This parameter is only supported for the `Hyperband` selection for
    /// `Strategy` within the `HyperParameterTuningJobConfig` API.
    hyperband_strategy_config: ?HyperbandStrategyConfig = null,

    pub const json_field_names = .{
        .hyperband_strategy_config = "HyperbandStrategyConfig",
    };
};
