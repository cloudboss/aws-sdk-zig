const AutoMLMetricEnum = @import("auto_ml_metric_enum.zig").AutoMLMetricEnum;
const AutoMLJobObjectiveType = @import("auto_ml_job_objective_type.zig").AutoMLJobObjectiveType;

/// The best candidate result from an AutoML training job.
pub const FinalAutoMLJobObjectiveMetric = struct {
    /// The name of the metric with the best result. For a description of the
    /// possible objective metrics, see
    /// [AutoMLJobObjective$MetricName](https://docs.aws.amazon.com/sagemaker/latest/APIReference/API_AutoMLJobObjective.html).
    metric_name: AutoMLMetricEnum,

    /// The name of the standard metric. For a description of the standard metrics,
    /// see [Autopilot candidate
    /// metrics](https://docs.aws.amazon.com/sagemaker/latest/dg/autopilot-metrics-validation.html#autopilot-metrics).
    standard_metric_name: ?AutoMLMetricEnum,

    /// The type of metric with the best result.
    type: ?AutoMLJobObjectiveType,

    /// The value of the metric with the best result.
    value: f32,

    pub const json_field_names = .{
        .metric_name = "MetricName",
        .standard_metric_name = "StandardMetricName",
        .type = "Type",
        .value = "Value",
    };
};
