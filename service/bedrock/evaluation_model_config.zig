const EvaluationBedrockModel = @import("evaluation_bedrock_model.zig").EvaluationBedrockModel;
const EvaluationPrecomputedInferenceSource = @import("evaluation_precomputed_inference_source.zig").EvaluationPrecomputedInferenceSource;

/// Defines the models used in the model evaluation job.
pub const EvaluationModelConfig = union(enum) {
    /// Defines the Amazon Bedrock model or inference profile and inference
    /// parameters you want used.
    bedrock_model: ?EvaluationBedrockModel,
    /// Defines the model used to generate inference response data for a model
    /// evaluation job where you provide your own inference response data.
    precomputed_inference_source: ?EvaluationPrecomputedInferenceSource,

    pub const json_field_names = .{
        .bedrock_model = "bedrockModel",
        .precomputed_inference_source = "precomputedInferenceSource",
    };
};
