const AutomatedEvaluationCustomMetricSource = @import("automated_evaluation_custom_metric_source.zig").AutomatedEvaluationCustomMetricSource;
const CustomMetricEvaluatorModelConfig = @import("custom_metric_evaluator_model_config.zig").CustomMetricEvaluatorModelConfig;

/// Defines the configuration of custom metrics to be used in an evaluation job.
/// To learn more about using custom metrics in Amazon Bedrock evaluation jobs,
/// see [Create a prompt for a custom metrics (LLM-as-a-judge model
/// evaluations)](https://docs.aws.amazon.com/bedrock/latest/userguide/model-evaluation-custom-metrics-prompt-formats.html) and [Create a prompt for a custom metrics (RAG evaluations)](https://docs.aws.amazon.com/bedrock/latest/userguide/kb-evaluation-custom-metrics-prompt-formats.html).
pub const AutomatedEvaluationCustomMetricConfig = struct {
    /// Defines a list of custom metrics to be used in an Amazon Bedrock evaluation
    /// job.
    custom_metrics: []const AutomatedEvaluationCustomMetricSource,

    /// Configuration of the evaluator model you want to use to evaluate custom
    /// metrics in an Amazon Bedrock evaluation job.
    evaluator_model_config: CustomMetricEvaluatorModelConfig,

    pub const json_field_names = .{
        .custom_metrics = "customMetrics",
        .evaluator_model_config = "evaluatorModelConfig",
    };
};
