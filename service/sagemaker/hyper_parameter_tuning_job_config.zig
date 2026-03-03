const HyperParameterTuningJobObjective = @import("hyper_parameter_tuning_job_objective.zig").HyperParameterTuningJobObjective;
const ParameterRanges = @import("parameter_ranges.zig").ParameterRanges;
const ResourceLimits = @import("resource_limits.zig").ResourceLimits;
const HyperParameterTuningJobStrategyType = @import("hyper_parameter_tuning_job_strategy_type.zig").HyperParameterTuningJobStrategyType;
const HyperParameterTuningJobStrategyConfig = @import("hyper_parameter_tuning_job_strategy_config.zig").HyperParameterTuningJobStrategyConfig;
const TrainingJobEarlyStoppingType = @import("training_job_early_stopping_type.zig").TrainingJobEarlyStoppingType;
const TuningJobCompletionCriteria = @import("tuning_job_completion_criteria.zig").TuningJobCompletionCriteria;

/// Configures a hyperparameter tuning job.
pub const HyperParameterTuningJobConfig = struct {
    /// The
    /// [HyperParameterTuningJobObjective](https://docs.aws.amazon.com/sagemaker/latest/APIReference/API_HyperParameterTuningJobObjective.html) specifies the objective metric used to evaluate the performance of training jobs launched by this tuning job.
    hyper_parameter_tuning_job_objective: ?HyperParameterTuningJobObjective = null,

    /// The
    /// [ParameterRanges](https://docs.aws.amazon.com/sagemaker/latest/APIReference/API_ParameterRanges.html) object that specifies the ranges of hyperparameters that this tuning job searches over to find the optimal configuration for the highest model performance against your chosen objective metric.
    parameter_ranges: ?ParameterRanges = null,

    /// A value used to initialize a pseudo-random number generator. Setting a
    /// random seed and using the same seed later for the same tuning job will allow
    /// hyperparameter optimization to find more a consistent hyperparameter
    /// configuration between the two runs.
    random_seed: ?i32 = null,

    /// The
    /// [ResourceLimits](https://docs.aws.amazon.com/sagemaker/latest/APIReference/API_ResourceLimits.html) object that specifies the maximum number of training and parallel training jobs that can be used for this hyperparameter tuning job.
    resource_limits: ResourceLimits,

    /// Specifies how hyperparameter tuning chooses the combinations of
    /// hyperparameter values to use for the training job it launches. For
    /// information about search strategies, see [How Hyperparameter Tuning
    /// Works](https://docs.aws.amazon.com/sagemaker/latest/dg/automatic-model-tuning-how-it-works.html).
    strategy: HyperParameterTuningJobStrategyType,

    /// The configuration for the `Hyperband` optimization strategy. This parameter
    /// should be provided only if `Hyperband` is selected as the strategy for
    /// `HyperParameterTuningJobConfig`.
    strategy_config: ?HyperParameterTuningJobStrategyConfig = null,

    /// Specifies whether to use early stopping for training jobs launched by the
    /// hyperparameter tuning job. Because the `Hyperband` strategy has its own
    /// advanced internal early stopping mechanism, `TrainingJobEarlyStoppingType`
    /// must be `OFF` to use `Hyperband`. This parameter can take on one of the
    /// following values (the default value is `OFF`):
    ///
    /// **OFF**
    ///
    /// Training jobs launched by the hyperparameter tuning job do not use early
    /// stopping.
    ///
    /// **AUTO**
    ///
    /// SageMaker stops training jobs launched by the hyperparameter tuning job when
    /// they are unlikely to perform better than previously completed training jobs.
    /// For more information, see [Stop Training Jobs
    /// Early](https://docs.aws.amazon.com/sagemaker/latest/dg/automatic-model-tuning-early-stopping.html).
    training_job_early_stopping_type: ?TrainingJobEarlyStoppingType = null,

    /// The tuning job's completion criteria.
    tuning_job_completion_criteria: ?TuningJobCompletionCriteria = null,

    pub const json_field_names = .{
        .hyper_parameter_tuning_job_objective = "HyperParameterTuningJobObjective",
        .parameter_ranges = "ParameterRanges",
        .random_seed = "RandomSeed",
        .resource_limits = "ResourceLimits",
        .strategy = "Strategy",
        .strategy_config = "StrategyConfig",
        .training_job_early_stopping_type = "TrainingJobEarlyStoppingType",
        .tuning_job_completion_criteria = "TuningJobCompletionCriteria",
    };
};
