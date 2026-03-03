const ClarifyInferenceConfig = @import("clarify_inference_config.zig").ClarifyInferenceConfig;
const ClarifyShapConfig = @import("clarify_shap_config.zig").ClarifyShapConfig;

/// The configuration parameters for the SageMaker Clarify explainer.
pub const ClarifyExplainerConfig = struct {
    /// A JMESPath boolean expression used to filter which records to explain.
    /// Explanations are activated by default. See [ `EnableExplanations`
    /// ](https://docs.aws.amazon.com/sagemaker/latest/dg/clarify-online-explainability-create-endpoint.html#clarify-online-explainability-create-endpoint-enable)for additional information.
    enable_explanations: ?[]const u8 = null,

    /// The inference configuration parameter for the model container.
    inference_config: ?ClarifyInferenceConfig = null,

    /// The configuration for SHAP analysis.
    shap_config: ClarifyShapConfig,

    pub const json_field_names = .{
        .enable_explanations = "EnableExplanations",
        .inference_config = "InferenceConfig",
        .shap_config = "ShapConfig",
    };
};
