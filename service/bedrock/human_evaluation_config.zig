const HumanEvaluationCustomMetric = @import("human_evaluation_custom_metric.zig").HumanEvaluationCustomMetric;
const EvaluationDatasetMetricConfig = @import("evaluation_dataset_metric_config.zig").EvaluationDatasetMetricConfig;
const HumanWorkflowConfig = @import("human_workflow_config.zig").HumanWorkflowConfig;

/// Specifies the custom metrics, how tasks will be rated, the flow definition
/// ARN, and your custom prompt datasets. Model evaluation jobs use human
/// workers *only* support the use of custom prompt datasets. To learn more
/// about custom prompt datasets and the required format, see [Custom prompt
/// datasets](https://docs.aws.amazon.com/bedrock/latest/userguide/model-evaluation-prompt-datasets-custom.html).
///
/// When you create custom metrics in `HumanEvaluationCustomMetric` you must
/// specify the metric's `name`. The list of `names` specified in the
/// `HumanEvaluationCustomMetric` array, must match the `metricNames` array of
/// strings specified in `EvaluationDatasetMetricConfig`. For example, if in the
/// `HumanEvaluationCustomMetric` array your specified the names `"accuracy",
/// "toxicity", "readability"` as custom metrics *then* the `metricNames` array
/// would need to look like the following `["accuracy", "toxicity",
/// "readability"]` in `EvaluationDatasetMetricConfig`.
pub const HumanEvaluationConfig = struct {
    /// A `HumanEvaluationCustomMetric` object. It contains the names the metrics,
    /// how the metrics are to be evaluated, an optional description.
    custom_metrics: ?[]const HumanEvaluationCustomMetric,

    /// Use to specify the metrics, task, and prompt dataset to be used in your
    /// model evaluation job.
    dataset_metric_configs: []const EvaluationDatasetMetricConfig,

    /// The parameters of the human workflow.
    human_workflow_config: ?HumanWorkflowConfig,

    pub const json_field_names = .{
        .custom_metrics = "customMetrics",
        .dataset_metric_configs = "datasetMetricConfigs",
        .human_workflow_config = "humanWorkflowConfig",
    };
};
