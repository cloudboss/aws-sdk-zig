const BedrockEvaluatorModelConfig = @import("bedrock_evaluator_model_config.zig").BedrockEvaluatorModelConfig;

/// The model configuration that specifies which foundation model to use for
/// evaluation and how to configure it.
pub const EvaluatorModelConfig = union(enum) {
    /// The Amazon Bedrock model configuration for evaluation.
    bedrock_evaluator_model_config: ?BedrockEvaluatorModelConfig,

    pub const json_field_names = .{
        .bedrock_evaluator_model_config = "bedrockEvaluatorModelConfig",
    };
};
