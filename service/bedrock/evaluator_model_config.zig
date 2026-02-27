const BedrockEvaluatorModel = @import("bedrock_evaluator_model.zig").BedrockEvaluatorModel;

/// Specifies the model configuration for the evaluator model.
/// `EvaluatorModelConfig` is required for evaluation jobs that use a knowledge
/// base or in model evaluation job that use a model as judge. This model
/// computes all evaluation related metrics.
pub const EvaluatorModelConfig = union(enum) {
    /// The evaluator model used in knowledge base evaluation job or in model
    /// evaluation job that use a model as judge. This model computes all evaluation
    /// related metrics.
    bedrock_evaluator_models: ?[]const BedrockEvaluatorModel,

    pub const json_field_names = .{
        .bedrock_evaluator_models = "bedrockEvaluatorModels",
    };
};
