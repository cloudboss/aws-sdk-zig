const BedrockEvaluatorModelConfig = @import("bedrock_evaluator_model_config.zig").BedrockEvaluatorModelConfig;
const OpenResponsesEvaluatorModelConfig = @import("open_responses_evaluator_model_config.zig").OpenResponsesEvaluatorModelConfig;

/// The model configuration that specifies which foundation model to use for
/// evaluation and how to configure it.
pub const EvaluatorModelConfig = union(enum) {
    /// The Amazon Bedrock model configuration for evaluation.
    bedrock_evaluator_model_config: ?BedrockEvaluatorModelConfig,
    /// The OpenResponses model configuration for evaluation.
    responses_evaluator_model_config: ?OpenResponsesEvaluatorModelConfig,

    pub const json_field_names = .{
        .bedrock_evaluator_model_config = "bedrockEvaluatorModelConfig",
        .responses_evaluator_model_config = "responsesEvaluatorModelConfig",
    };
};
