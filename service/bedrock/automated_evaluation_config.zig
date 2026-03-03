const AutomatedEvaluationCustomMetricConfig = @import("automated_evaluation_custom_metric_config.zig").AutomatedEvaluationCustomMetricConfig;
const EvaluationDatasetMetricConfig = @import("evaluation_dataset_metric_config.zig").EvaluationDatasetMetricConfig;
const EvaluatorModelConfig = @import("evaluator_model_config.zig").EvaluatorModelConfig;

/// The configuration details of an automated evaluation job. The
/// `EvaluationDatasetMetricConfig` object is used to specify the prompt
/// datasets, task type, and metric names.
pub const AutomatedEvaluationConfig = struct {
    /// Defines the configuration of custom metrics to be used in an evaluation job.
    custom_metric_config: ?AutomatedEvaluationCustomMetricConfig = null,

    /// Configuration details of the prompt datasets and metrics you want to use for
    /// your evaluation job.
    dataset_metric_configs: []const EvaluationDatasetMetricConfig,

    /// Contains the evaluator model configuration details. `EvaluatorModelConfig`
    /// is required for evaluation jobs that use a knowledge base or in model
    /// evaluation job that use a model as judge. This model computes all evaluation
    /// related metrics.
    evaluator_model_config: ?EvaluatorModelConfig = null,

    pub const json_field_names = .{
        .custom_metric_config = "customMetricConfig",
        .dataset_metric_configs = "datasetMetricConfigs",
        .evaluator_model_config = "evaluatorModelConfig",
    };
};
