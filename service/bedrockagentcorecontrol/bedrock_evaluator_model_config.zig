const InferenceConfiguration = @import("inference_configuration.zig").InferenceConfiguration;

/// The configuration for using Amazon Bedrock models in evaluator assessments,
/// including model selection and inference parameters.
pub const BedrockEvaluatorModelConfig = struct {
    /// Additional model-specific request fields to customize model behavior beyond
    /// the standard inference configuration.
    additional_model_request_fields: ?[]const u8 = null,

    /// The inference configuration parameters that control model behavior during
    /// evaluation, including temperature, token limits, and sampling settings.
    inference_config: ?InferenceConfiguration = null,

    /// The identifier of the Amazon Bedrock model to use for evaluation. Must be a
    /// supported foundation model available in your region.
    model_id: []const u8,

    pub const json_field_names = .{
        .additional_model_request_fields = "additionalModelRequestFields",
        .inference_config = "inferenceConfig",
        .model_id = "modelId",
    };
};
