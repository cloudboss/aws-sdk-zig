const CustomMetricBedrockEvaluatorModel = @import("custom_metric_bedrock_evaluator_model.zig").CustomMetricBedrockEvaluatorModel;

/// Configuration of the evaluator model you want to use to evaluate custom
/// metrics in an Amazon Bedrock evaluation job.
pub const CustomMetricEvaluatorModelConfig = struct {
    /// Defines the model you want to evaluate custom metrics in an Amazon Bedrock
    /// evaluation job.
    bedrock_evaluator_models: []const CustomMetricBedrockEvaluatorModel,

    pub const json_field_names = .{
        .bedrock_evaluator_models = "bedrockEvaluatorModels",
    };
};
