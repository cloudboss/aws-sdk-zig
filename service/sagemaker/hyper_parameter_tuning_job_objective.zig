const HyperParameterTuningJobObjectiveType = @import("hyper_parameter_tuning_job_objective_type.zig").HyperParameterTuningJobObjectiveType;

/// Defines the objective metric for a hyperparameter tuning job. Hyperparameter
/// tuning uses the value of this metric to evaluate the training jobs it
/// launches, and returns the training job that results in either the highest or
/// lowest value for this metric, depending on the value you specify for the
/// `Type` parameter. If you want to define a custom objective metric, see
/// [Define metrics and environment
/// variables](https://docs.aws.amazon.com/sagemaker/latest/dg/automatic-model-tuning-define-metrics-variables.html).
pub const HyperParameterTuningJobObjective = struct {
    /// The name of the metric to use for the objective metric.
    metric_name: []const u8,

    /// Whether to minimize or maximize the objective metric.
    type: HyperParameterTuningJobObjectiveType,

    pub const json_field_names = .{
        .metric_name = "MetricName",
        .type = "Type",
    };
};
