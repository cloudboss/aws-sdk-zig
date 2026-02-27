const ClarifyShapBaselineConfig = @import("clarify_shap_baseline_config.zig").ClarifyShapBaselineConfig;
const ClarifyTextConfig = @import("clarify_text_config.zig").ClarifyTextConfig;

/// The configuration for SHAP analysis using SageMaker Clarify Explainer.
pub const ClarifyShapConfig = struct {
    /// The number of samples to be used for analysis by the Kernal SHAP algorithm.
    ///
    /// The number of samples determines the size of the synthetic dataset, which
    /// has an impact on latency of explainability requests. For more information,
    /// see the **Synthetic data** of [Configure and create an
    /// endpoint](https://docs.aws.amazon.com/sagemaker/latest/dg/clarify-online-explainability-create-endpoint.html).
    number_of_samples: ?i32,

    /// The starting value used to initialize the random number generator in the
    /// explainer. Provide a value for this parameter to obtain a deterministic SHAP
    /// result.
    seed: ?i32,

    /// The configuration for the SHAP baseline of the Kernal SHAP algorithm.
    shap_baseline_config: ClarifyShapBaselineConfig,

    /// A parameter that indicates if text features are treated as text and
    /// explanations are provided for individual units of text. Required for natural
    /// language processing (NLP) explainability only.
    text_config: ?ClarifyTextConfig,

    /// A Boolean toggle to indicate if you want to use the logit function (true) or
    /// log-odds units (false) for model predictions. Defaults to false.
    use_logit: ?bool,

    pub const json_field_names = .{
        .number_of_samples = "NumberOfSamples",
        .seed = "Seed",
        .shap_baseline_config = "ShapBaselineConfig",
        .text_config = "TextConfig",
        .use_logit = "UseLogit",
    };
};
