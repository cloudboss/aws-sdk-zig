/// The configuration for inference parameters when using AI Prompts.
pub const AIPromptInferenceConfiguration = struct {
    /// The maximum number of tokens to generate in the response.
    max_tokens_to_sample: ?i32 = null,

    /// The temperature setting for controlling randomness in the generated
    /// response.
    temperature: ?f32 = null,

    /// The top-K sampling parameter for token selection.
    top_k: ?i32 = null,

    /// The top-P sampling parameter for nucleus sampling.
    top_p: ?f32 = null,

    pub const json_field_names = .{
        .max_tokens_to_sample = "maxTokensToSample",
        .temperature = "temperature",
        .top_k = "topK",
        .top_p = "topP",
    };
};
