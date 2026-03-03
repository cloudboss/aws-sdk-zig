const HyperParameterTuningJobObjectiveType = @import("hyper_parameter_tuning_job_objective_type.zig").HyperParameterTuningJobObjectiveType;

/// Shows the latest objective metric emitted by a training job that was
/// launched by a hyperparameter tuning job. You define the objective metric in
/// the `HyperParameterTuningJobObjective` parameter of
/// [HyperParameterTuningJobConfig](https://docs.aws.amazon.com/sagemaker/latest/APIReference/API_HyperParameterTuningJobConfig.html).
pub const FinalHyperParameterTuningJobObjectiveMetric = struct {
    /// The name of the objective metric. For SageMaker built-in algorithms, metrics
    /// are defined per algorithm. See the [metrics for
    /// XGBoost](https://docs.aws.amazon.com/sagemaker/latest/dg/xgboost-tuning.html) as an example. You can also use a custom algorithm for training and define your own metrics. For more information, see [Define metrics and environment variables](https://docs.aws.amazon.com/sagemaker/latest/dg/automatic-model-tuning-define-metrics-variables.html).
    metric_name: []const u8,

    /// Select if you want to minimize or maximize the objective metric during
    /// hyperparameter tuning.
    @"type": ?HyperParameterTuningJobObjectiveType = null,

    /// The value of the objective metric.
    value: f32,

    pub const json_field_names = .{
        .metric_name = "MetricName",
        .@"type" = "Type",
        .value = "Value",
    };
};
