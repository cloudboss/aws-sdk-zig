/// A summary of the models used in an Amazon Bedrock model evaluation job.
/// These resources can be models in Amazon Bedrock or models outside of Amazon
/// Bedrock that you use to generate your own inference response data.
pub const EvaluationModelConfigSummary = struct {
    /// The Amazon Resource Names (ARNs) of the models used for the evaluation job.
    bedrock_model_identifiers: ?[]const []const u8 = null,

    /// A label that identifies the models used for a model evaluation job where you
    /// provide your own inference response data.
    precomputed_inference_source_identifiers: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .bedrock_model_identifiers = "bedrockModelIdentifiers",
        .precomputed_inference_source_identifiers = "precomputedInferenceSourceIdentifiers",
    };
};
